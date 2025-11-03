import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_roulette/routes/app_routes.dart';
import 'package:meal_roulette/routes/app_routes_constants.dart';

import 'configs/resources/resources.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    nextScreen();
  }

  void nextScreen() {
    Future.delayed(const Duration(seconds: 1)).then((_) {
      rootNavigatorKey.currentContext!.go(AppRouteConstants.home);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height,
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [R.colors.splashGrad1, R.colors.splashGrad2],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Center(
            child: SvgPicture.asset(
              R.assets.appBarLogo,
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width,
            )),
      ),
    );
  }
}
