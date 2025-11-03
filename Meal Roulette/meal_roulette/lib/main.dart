import 'package:flutter/material.dart';
import 'package:meal_roulette/routes/app_routes.dart';

import 'configs/common_widgets/app_theme.dart';
import 'injector.dart';

void main() {
  runApp(Injector(myApp: const LunchBuddyApp()));
}

class LunchBuddyApp extends StatelessWidget {
  const LunchBuddyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Meal Roulette',
      routerConfig: AppRoutes.router,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
    );
  }
}