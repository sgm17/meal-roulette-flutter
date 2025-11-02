import 'package:flutter/material.dart';
import 'package:meal_roulette/injector.dart';
import 'package:meal_roulette/routes/app_routes.dart';

Future<void> main() async {
 // final binding = WidgetsFlutterBinding.ensureInitialized();
 // FlutterNativeSplash.preserve(widgetsBinding: binding);

  runApp(Injector(myApp: const MyApp()));
 // await Future.delayed(const Duration(milliseconds: 1));
 // FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRoutes.router,
      debugShowCheckedModeBanner: false,
      title: 'HWB Stats',
    );
  }
}