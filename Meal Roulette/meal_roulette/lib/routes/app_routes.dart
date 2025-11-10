
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_roulette/configs/common_widgets/app_nav_bar.dart';
import 'package:meal_roulette/configs/utils/aap_utils.dart';
import 'package:meal_roulette/modules/auth/presentation/view/auth_screen.dart';
import 'package:meal_roulette/modules/details/presentation/view/details_view.dart';
import 'package:meal_roulette/modules/matching/presentation/view/matching_view.dart';
import 'package:meal_roulette/modules/mensa/data/models/mensa_models.dart';
import 'package:meal_roulette/modules/mensa/presentation/view/mensa_view.dart';
import 'package:meal_roulette/modules/profile/presentation/view/profile_view.dart';
import 'package:meal_roulette/splash.dart';

import 'app_routes_constants.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();

BuildContext getContext() => rootNavigatorKey.currentContext!;

class AppRoutes {
  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRouteConstants.defaultRoute,
   debugLogDiagnostics: true,
   /* redirect: (context, state) {
      final loggedIn = FirebaseAuth.instance.currentUser != null;
      final loggingIn = state.matchedLocation == AppRouteConstants.auth;
      if (!loggedIn) return loggingIn ? null : AppRouteConstants.auth;
      if (loggingIn) return AppRouteConstants.home;
      return null;
    },*/
    //errorBuilder: (context, state) => ErrorPage(state.error),
    routes: [
      GoRoute(
        path: AppRouteConstants.defaultRoute,
        pageBuilder: (context, state) => NoTransitionPage(child: SplashView()),
      ),
      GoRoute(
        path: AppRouteConstants.auth,
        name: AppRouteConstants.auth,
        //pageBuilder: (context, state) => Utils().buildPageWithSlideTransition(context: context, state: state, child: AuthView()), routes: [],
        pageBuilder: (context, state) => Utils().buildPageWithSlideTransition(context: context, state: state, child: AuthView()),
        routes: [],
      ),

      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return AppNavBar(child: child);
        },
        routes: [
          // HOME TAB
          GoRoute(
            path: AppRouteConstants.home,
            name: AppRouteConstants.home,
            pageBuilder: (context, state) => NoTransitionPage(child: MensaView()),
            routes: [
              GoRoute(
                path: AppRouteConstants.details,
                name: AppRouteConstants.details,
                pageBuilder: (context, state) => Utils().buildPageWithRightToLeftTransition(
                  context: context,
                  state: state,
                  child: DetailsView(mensa: state.extra as MensaModel),
                ),
                routes: [],
              ),
              // GoRoute(path: AppRouteConstants.notifications, name: AppRouteConstants.notifications, pageBuilder: (context, state) => NoTransitionPage(child: NotificationsView()), routes: []),
              // GoRoute(path: AppRouteConstants.settings, name: AppRouteConstants.settings, pageBuilder: (context, state) => NoTransitionPage(child: SettingsView()), routes: []),
              // GoRoute(path: AppRouteConstants.contact, name: AppRouteConstants.contact, pageBuilder: (context, state) => NoTransitionPage(child: ContactView()), routes: []),
              // GoRoute(path: AppRouteConstants.privacy, name: AppRouteConstants.privacy, pageBuilder: (context, state) => NoTransitionPage(child: PrivacyView()), routes: []),
            ],
          ),
          GoRoute(
            path: AppRouteConstants.matches,
            name: AppRouteConstants.matches,
            //pageBuilder: (context, state) => Utils().buildPageWithRightToLeftTransition(context: context, state: state, child: MatchingView()),
            pageBuilder: (context, state) => NoTransitionPage(child: MatchingView()),
            routes: [],
          ),
          GoRoute(
            path: AppRouteConstants.profile,
            name: AppRouteConstants.profile,
            pageBuilder: (context, state) => NoTransitionPage(child: ProfileView()),
            routes: [],
          ),
        ],
      ),
    ],
  );
}
