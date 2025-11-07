

import 'package:meal_roulette/modules/auth/data/data_sources/auth_service.dart';

import '../models/user_model.dart';

/// Repository layer that adapts AuthService to the app's domain.
/// This indirection makes it easy to swap the service during tests or implement caching.
class AuthDataRepository {
  final AuthService _service;
  AuthDataRepository({required AuthService service}) : _service = service;

  Stream<String?> get authIdStream => _service.authStateChanges().map((u) => u?.uid);

  Future<UserModel?> register({required String name, required String phone, required String email, required String password, String? avatarUrl}) =>
      _service.register(name: name, phone: phone, email: email, password: password, avatarUrl: avatarUrl);

  Future<UserModel> login({required String email, required String password}) => _service.login(email: email, password: password);

  Future<void> logout() => _service.logout();

  Future<UserModel?> fetchProfile(String uid) => _service.fetchProfile(uid);

  Stream<UserModel?> streamProfile(String uid) => _service.streamProfile(uid);
}
