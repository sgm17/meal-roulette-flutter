import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meal_roulette/modules/auth/data/models/user_model.dart';

/// Low-level Firebase interactions for user profiles.
/// Keeps Firestore logic centralized and testable.
class ProfileService {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final String usersCollection;

  ProfileService({
    FirebaseAuth? auth,
    FirebaseFirestore? firestore,
    this.usersCollection = 'users',
  })  : _auth = auth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  /// Get current user's UID, throws if no authenticated user.
  String get _uid {
    final u = _auth.currentUser;
    if (u == null) throw FirebaseAuthException(code: 'no-current-user', message: 'No authenticated user found');
    return u.uid;
  }

  /// One-off fetch of the current user's profile document.
  Future<UserModel?> getUserProfileOnce({String? uid}) async {
    final userId = uid ?? _uid;
    final doc = await _firestore.collection(usersCollection).doc(userId).get();
    if (!doc.exists || doc.data() == null) return null;
    return UserModel.fromMap(doc.data()!);
  }

  /// Stream of the authenticated user's profile for real-time syncing.
  Stream<UserModel?> watchUserProfile({String? uid}) {
    final userId = uid ?? _uid;
    return _firestore.collection(usersCollection).doc(userId).snapshots().map((snap) {
      if (!snap.exists || snap.data() == null) return null;
      return UserModel.fromMap(snap.data()!);
    });
  }

  /// Update the current user's profile; merges fields by default.
  Future<void> updateUserProfile(UserModel user) async {
    await _firestore.collection(usersCollection).doc(user.uid).set(user.toMap(), SetOptions(merge: true));
  }

  /// Optionally create a user profile if missing (useful on first sign-in).
  Future<UserModel> ensureUserProfileExists({String? uid}) async {
    final userId = uid ?? _uid;
    final docRef = _firestore.collection(usersCollection).doc(userId);
    final doc = await docRef.get();

    if (doc.exists && doc.data() != null) {
      return UserModel.fromMap(doc.data()!);
    }

    // Build a minimal profile from FirebaseAuth user data
    final authUser = _auth.currentUser;
    final profile = UserModel(
      uid: userId,
      name: authUser?.displayName ?? '',
      email: authUser?.email ?? '',
      avatarUrl: authUser?.photoURL,
      fcmToken: null, phone: authUser?.phoneNumber ?? '',
    );

    await docRef.set(profile.toMap());
    return profile;
  }

  /// Update lastSeen server-side timestamp for presence-like behavior.
  Future<void> touchLastSeen({String? uid}) async {
    final userId = uid ?? _uid;
    await _firestore.collection(usersCollection).doc(userId).update({
      'lastSeen': FieldValue.serverTimestamp(),
    });
  }
}
