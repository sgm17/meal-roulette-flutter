import 'package:flutter/material.dart';
import 'package:meal_roulette/modules/auth/data/data_sources/auth_service.dart';
import 'package:meal_roulette/modules/auth/data/repository/auth_data_repository.dart';
import 'package:provider/provider.dart';
import 'modules/auth/presentation/provider/auth_provider.dart';

class Injector extends StatelessWidget {
  final Widget myApp;

  Injector({super.key, required this.myApp});

  // Instantiate core service & repository once (singleton-ish)
  final authService = AuthService();
  AuthDataRepository get authRepository => AuthDataRepository(service: authService);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => AuthProvider(repository: authRepository)),

    ], child: myApp);
  }
}
