import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_roulette/configs/resources/resources.dart';
import 'package:meal_roulette/configs/resources/sizing.dart';
import 'package:meal_roulette/modules/matching/presentation/view/matching_view.dart';
import 'package:meal_roulette/modules/mensa/presentation/view/mensa_view.dart';
import 'package:meal_roulette/modules/profile/presentation/view/profile_view.dart';
import 'package:meal_roulette/routes/app_routes_constants.dart';


class AppNavBar extends StatefulWidget {
  final Widget child;

  const AppNavBar({super.key, required this.child});

  @override
  State<AppNavBar> createState() => _AppNavBarState();
}

class _AppNavBarState extends State<AppNavBar> {
  int currentIndex = 0;
  int previousIndex = 0;
  final List<Widget> _screens = [
    const MensaView(),
    const MatchingView(),
    const ProfileView(),
  ];

  final tabs = [_NavItem(icon: Icons.home_rounded, label: 'Home', route: AppRouteConstants.home), _NavItem(icon: Icons.people_alt_rounded, label: 'Match', route: AppRouteConstants.matches), _NavItem(icon: Icons.person_rounded, label: 'Profile', route: AppRouteConstants.profile)];

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    currentIndex = _getSelectedIndex(location);

    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: R.colors.red.withValues(alpha: 0.1),
          labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
                (states) {
              if (states.contains(WidgetState.selected)) {
                return R.textStyles.font10B.copyWith(color: R.colors.red);
              }
              return R.textStyles.font10R.copyWith(color: R.colors.red);
            },
          ),
          iconTheme: WidgetStateProperty.resolveWith<IconThemeData>(
                (states) => IconThemeData(
              color: states.contains(WidgetState.selected)
                  ? R.colors.white
                  : R.colors.red,
            ),
          ),
        ),
        child: NavigationBar(
          height: 70.h,
          elevation: 5,
          indicatorColor: R.colors.red,
          selectedIndex: currentIndex,
          /*onDestinationSelected: (index) {
            context.go(tabs[index].route);
          },*/
          onDestinationSelected: (index) {
            setState(() => currentIndex = index);
            context.go(tabs[index].route);
          },
          destinations: tabs.map((tab) => NavigationDestination(icon: Icon(tab.icon), label: tab.label)).toList(),

        ),
      ),
    );
  }

  int _getSelectedIndex(String location) {
    if (location.startsWith(AppRouteConstants.home)) return 0;
    if (location.startsWith(AppRouteConstants.matches)) return 1;
    if (location.startsWith(AppRouteConstants.profile)) return 2;
    return 0;
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  final String route;

  const _NavItem({required this.icon, required this.label, required this.route});
}
