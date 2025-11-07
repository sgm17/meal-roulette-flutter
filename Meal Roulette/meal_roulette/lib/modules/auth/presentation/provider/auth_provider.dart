import 'dart:async';
import 'package:flutter/material.dart';
import 'package:meal_roulette/modules/auth/data/models/user_model.dart';
import 'package:meal_roulette/modules/auth/data/repository/auth_data_repository.dart';

/// AuthProvider exposes simple, testable auth state and actions.
/// Uses ChangeNotifier so UI can listen and react to state changes.
class AuthProvider extends ChangeNotifier {
  final AuthDataRepository _repository;

  AuthProvider({required AuthDataRepository repository}) : _repository = repository {
    _init();
  }

  UserModel? _user;
  bool _isLoading = false;
  String? _error;
  StreamSubscription<UserModel?>? _profileSubscription;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _user != null;

  void _setLoading(bool v) {
    _isLoading = v;
    notifyListeners();
  }

  void _setError(String? message) {
    _error = message;
    notifyListeners();
  }

  /// Internal: initialize listening to auth state changes and hydrate user profile
  Future<void> _init() async {
    // Listen to low-level Firebase auth changes via repository's authIdStream
    _repository.authIdStream.listen((uid) async {
      // Clean-up any previous subscription
      await _profileSubscription?.cancel();
      if (uid == null) {
        _user = null;
        notifyListeners();
      } else {
        // Subscribe to realtime profile updates
        _profileSubscription = _repository.streamProfile(uid).listen((profile) {
          _user = profile;
          notifyListeners();
        }, onError: (e) {
          // best-effort fallback to one-off fetch
          _repository.fetchProfile(uid).then((p) {
            _user = p;
            notifyListeners();
          });
        });
      }
    });
  }

  /// Register a user and auto-sign-in (returns profile on success)
  Future<UserModel?> register({required String name, required String phone, required String email, required String password}) async {
    _setLoading(true);
    _setError(null);
    try {
      final profile = await _repository.register(name: name, phone: phone, email: email, password: password);
      _user = profile;
      return profile;
    } catch (e) {
      _setError(_friendlyError(e));
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  /// Login with email/password
  Future<UserModel?> login({required String email, required String password}) async {
    _setLoading(true);
    _setError(null);
    try {
      final profile = await _repository.login(email: email, password: password);
      _user = profile;
      return profile;
    } catch (e) {
      _setError(_friendlyError(e));
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  /// Logout
  Future<void> logout() async {
    _setLoading(true);
    _setError(null);
    try {
      await _repository.logout();
      _user = null;
    } catch (e) {
      _setError(_friendlyError(e));
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  /// Fetch fresh profile on demand
  Future<void> refreshProfile() async {
    if (_user == null) return;
    _setLoading(true);
    try {
      final latest = await _repository.fetchProfile(_user!.uid);
      _user = latest;
    } finally {
      _setLoading(false);
      notifyListeners();
    }
  }

  void disposeProvider() {
    _profileSubscription?.cancel();
    super.dispose();
  }

  String _friendlyError(Object e) {
    // Map common Firebase exception messages to friendly strings.
    final message = e.toString();
    if (message.contains('email-already-in-use')) return 'Email already in use';
    if (message.contains('wrong-password')) return 'Invalid credentials';
    if (message.contains('user-not-found')) return 'No account found with this email';
    return 'Authentication error: ${message.split(':').last}';
  }
}

