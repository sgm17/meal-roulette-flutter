import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_roulette/routes/app_routes.dart';
import 'package:meal_roulette/routes/app_routes_constants.dart';
import 'package:provider/provider.dart';

import 'configs/resources/resources.dart';
import 'modules/auth/presentation/provider/auth_provider.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  void nextScreen() {
    final auth = Provider.of<AuthProvider>(context);

    Future.delayed(const Duration(seconds: 1)).then((_) {
      if (auth.isAuthenticated) {
        rootNavigatorKey.currentContext!.go(AppRouteConstants.home);
      } else {
        rootNavigatorKey.currentContext!.go(AppRouteConstants.auth);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    nextScreen();

    return Container(
      height: MediaQuery.sizeOf(context).height,
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [R.colors.splashGrad1, R.colors.splashGrad2], begin: Alignment.topCenter, end: Alignment.bottomCenter),
      ),
      /*child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Center(
            child: SvgPicture.asset(
              R.assets.appBarLogo,
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width,
            )),
      ),*/
    );
  }
}
