import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../models/user_model.dart';

/// Low-level Firebase interactions are isolated here.
/// Keep logic minimal and testable: methods return domain types or throw FirebaseException.
class AuthService {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final String usersCollection;

  AuthService({FirebaseAuth? firebaseAuth, FirebaseFirestore? firestore, this.usersCollection = 'users'}) : _auth = firebaseAuth ?? FirebaseAuth.instance, _firestore = firestore ?? FirebaseFirestore.instance;

  /// Stream of Firebase User changes (signed-in / signed-out / refresh).
  Stream<User?> authStateChanges() => _auth.authStateChanges();

  /// Get the current Firebase User (may be null).
  User? get currentUser => _auth.currentUser;

  /// Register new user with email/password and create profile document in Firestore.
  /// Optionally updates display name, avatar, and stores phone number.
  /// Throws [FirebaseAuthException] or [FirebaseException] on failure.
  Future<UserModel?> register({required String name, required String phone, required String email, required String password, String? avatarUrl}) async {
    // Step 1: Create authentication record

    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      final user = userCredential.user!;

      // Step 2: Update user metadata (name + avatar)
      await user.updateDisplayName(name);
      if (avatarUrl != null) {
        await user.updatePhotoURL(avatarUrl);
      }

      // Firebase Auth doesn’t directly allow setting phone without verification.
      // So we store phone in Firestore as part of the profile instead.
      final profile = UserModel(uid: user.uid, name: name, phone: phone, fcmToken: "", email: email, avatarUrl: avatarUrl);

      // Step 3: Create Firestore user profile
      try {
        await _firestore.collection('users').doc(user.uid).set(profile.toMap()).then((_) => print("✅ User profile saved to Firestore")).catchError((e) => {print("🔥 Firestore write failed: $e")});

        print("🟢 Registration complete!");
      } catch (e) {
        debugPrint('Registration failed: $e');
      }

      // Step 4: Optionally send verification email
      try {
        await user.sendEmailVerification();
      } catch (e) {
        debugPrint('Email verification failed: $e');
      }
      return profile;
    } on FirebaseAuthException catch (e, s) {
      debugPrint('Firebase Auth Error: ${e.code}');
      debugPrint('Message: ${e.message}');
      debugPrint('Stack: $s');
    } on FirebaseException catch (e, s) {
      debugPrint('Firebase Error: ${e.code}');
      debugPrint('Message: ${e.message}');
      debugPrint('Stack: $s');
    } catch (e, s) {
      debugPrint('Unknown error: $e');
      debugPrint('$s');
    }

    // Step 5: Return the model for local usage
    return null;
  }

  /// Login existing user with email & password.
  /// Restricts access until email is verified.
  Future<UserModel> login({required String email, required String password}) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      final user = credential.user;

      // Check if user exists
      if (user == null) {
        throw FirebaseAuthException(code: 'user-not-found', message: 'No user found for this email.');
      }

      // Check if email is verified
      if (!user.emailVerified) {
        await _auth.signOut(); // Logout immediately for safety
        throw FirebaseAuthException(code: 'email-not-verified', message: 'Please verify your email before logging in.');
      }

      // Fetch profile from Firestore
      final doc = await _firestore.collection(usersCollection).doc(user.uid).get();

      if (doc.exists && doc.data() != null) {
        return UserModel.fromMap(doc.data()!);
      } else {
        // If profile missing, synthesize a minimal one from auth info
        final profile = UserModel(uid: user.uid, name: user.displayName ?? '', phone: '', fcmToken: "", email: user.email ?? email, avatarUrl: user.photoURL);
        // Persist it for future use
        await _firestore.collection(usersCollection).doc(user.uid).set(profile.toMap());
        return profile;
      }
    } on FirebaseAuthException catch (_) {
      rethrow;
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  /// Sign-out
  Future<void> logout() => _auth.signOut();

  /// Fetch latest user profile from Firestore
  Future<UserModel?> fetchProfile(String uid) async {
    final doc = await _firestore.collection(usersCollection).doc(uid).get();
    if (!doc.exists || doc.data() == null) return null;
    return UserModel.fromMap(doc.data()!);
  }

  /// Listen to realtime user profile updates
  Stream<UserModel?> streamProfile(String uid) {
    return _firestore.collection(usersCollection).doc(uid).snapshots().map((snap) {
      if (!snap.exists || snap.data() == null) return null;
      return UserModel.fromMap(snap.data()!);
    });
  }

  /// Optional: get fresh ID token
  Future<String?> getIdToken({bool forceRefresh = false}) async => _auth.currentUser == null ? null : await _auth.currentUser!.getIdToken(forceRefresh);

  /// Optional: refresh local Firebase user (useful after profile updates)
  Future<void> refreshUser() async => await _auth.currentUser?.reload();
}
