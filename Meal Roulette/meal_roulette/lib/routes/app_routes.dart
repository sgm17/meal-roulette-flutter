import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_roulette/configs/utils/aap_utils.dart';
import 'package:meal_roulette/modules/mensa/presentation/view/mensa_view.dart';
import 'package:meal_roulette/splash.dart';

import 'app_routes_constants.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

BuildContext getContext() => rootNavigatorKey.currentContext!;

class AppRoutes {
  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRouteConstants.defaultRoute,
    /* redirect: (BuildContext context, GoRouterState state) {
      final isAuthenticated = true// your logic to check if user is authenticated
      if (!isAuthenticated) {
        return '/login';
      } else {
        return null; // return "null" to display the intended route without redirecting
      }
    },*/
    //errorBuilder: (context, state) => ErrorPage(state.error),
    routes: [
      GoRoute(
        path: AppRouteConstants.defaultRoute,
        pageBuilder: (context, state) => NoTransitionPage(child: SplashView()),
      ),
      GoRoute(path: AppRouteConstants.home, name: AppRouteConstants.home, pageBuilder: (context, state) => Utils().buildPageWithSlideTransition(context: context, state: state, child: MensaView()), routes: [
        // GoRoute(path: AppRouteConstants.matches, name: AppRouteConstants.matches, pageBuilder: (context, state) => NoTransitionPage(child: SelectMatch()), routes: [
        //   GoRoute(
        //     path: AppRouteConstants.profile,
        //     name: AppRouteConstants.profile,
        //     pageBuilder: (context, state) => NoTransitionPage(child: ViewProfile()),
        //     routes: [],
        //   ),
        //  ]),
        // GoRoute(path: AppRouteConstants.details, name: AppRouteConstants.details, pageBuilder: (context, state) => NoTransitionPage(child: DetailsView()), routes: []),
        // GoRoute(path: AppRouteConstants.notifications, name: AppRouteConstants.notifications, pageBuilder: (context, state) => NoTransitionPage(child: NotificationsView()), routes: []),
        // GoRoute(path: AppRouteConstants.settings, name: AppRouteConstants.settings, pageBuilder: (context, state) => NoTransitionPage(child: SettingsView()), routes: []),
        // GoRoute(path: AppRouteConstants.contact, name: AppRouteConstants.contact, pageBuilder: (context, state) => NoTransitionPage(child: ContactView()), routes: []),
        // GoRoute(path: AppRouteConstants.privacy, name: AppRouteConstants.privacy, pageBuilder: (context, state) => NoTransitionPage(child: PrivacyView()), routes: []),
      ],),],
  );
}
