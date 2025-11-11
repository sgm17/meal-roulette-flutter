import 'package:flutter/material.dart';
import 'package:meal_roulette/modules/auth/data/data_sources/auth_service.dart';
import 'package:meal_roulette/modules/auth/data/repository/auth_data_repository.dart';
import 'package:meal_roulette/modules/matching/presentation/provider/matching_provider.dart';
import 'package:meal_roulette/modules/mensa/presentation/provider/mensa_provider.dart';
import 'package:provider/provider.dart';
import 'modules/auth/presentation/provider/auth_provider.dart';
import 'modules/mensa/data/data_sources/mensa_service.dart';
import 'modules/mensa/data/repository/mensa_repository.dart';
import 'modules/profile/data/data_sources/profile_service.dart';
import 'modules/profile/presentation/provider/profile_provider.dart';

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
      ChangeNotifierProvider(create: (_) => MensaProvider(MensaRepository(MensaService()))),
      ChangeNotifierProvider(create: (_) => ProfileProvider(service: ProfileService())),
      ChangeNotifierProvider(create: (_) => MatchingProvider()),
    ], child: myApp);
  }
}
