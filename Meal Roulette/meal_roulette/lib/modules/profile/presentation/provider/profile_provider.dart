import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:meal_roulette/modules/auth/data/models/user_model.dart';
import 'package:meal_roulette/modules/profile/data/data_sources/profile_service.dart';

/// Provider (ChangeNotifier) that exposes profile data and convenience methods.
/// UI can listen to this provider for reactive updates.
class ProfileProvider extends ChangeNotifier {
  final ProfileService _service;

  UserModel? _user;
  UserModel? get user => _user;

  bool _loading = false;
  bool get loading => _loading;

  String? _error;
  String? get error => _error;

  StreamSubscription<UserModel?>? _subscription;

  ProfileProvider({required ProfileService service}) : _service = service;

  /// Start watching the user's profile in realtime.
  void startListening({String? uid}) {
    _loading = true;
    notifyListeners();

    _subscription?.cancel();
    _subscription = _service.watchUserProfile(uid: uid).listen((model) {
      _user = model;
      _loading = false;
      _error = null;
      notifyListeners();
    }, onError: (e) {
      _error = e.toString();
      _loading = false;
      notifyListeners();
    });
  }

  /// Stop listening (call on dispose of screen if needed)
  void stopListening() {
    _subscription?.cancel();
    _subscription = null;
  }

  /// One-off fetch
  Future<void> reload({String? uid}) async {
    _loading = true;
    notifyListeners();
    try {
      _user = await _service.getUserProfileOnce(uid: uid);
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  /// Update profile via service
  Future<void> updateProfile(UserModel updated) async {
    _loading = true;
    notifyListeners();
    try {
      await _service.updateUserProfile(updated);
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  /// Create profile if missing (helper)
  Future<UserModel?> ensureProfile({String? uid}) async {
    _loading = true;
    notifyListeners();
    try {
      final profile = await _service.ensureUserProfileExists(uid: uid);
      _user = profile;
      _error = null;
      return profile;
    } catch (e) {
      _error = e.toString();
      return null;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
