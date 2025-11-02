import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'modules/auth/domain/usecases/auth_usecases.dart';
import 'modules/auth/presentation/provider/auth_provider.dart';

class Injector extends StatelessWidget {
  final Widget myApp;

  Injector({super.key, required this.myApp});

  // Used cases
  final AuthUsecases getRegionsUseCase = AuthUsecases();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => AuthProvider()),

    ], child: myApp);
  }
}
