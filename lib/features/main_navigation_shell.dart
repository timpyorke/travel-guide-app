import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_guide/base/models/main_navigation_menu.dart';

class MainNavigationShell extends StatelessWidget {
  const MainNavigationShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  void _onDestinationSelected(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: _onDestinationSelected,
        destinations: <NavigationDestination>[
          ...MainNavigationMenu.values.map(
            (menu) => NavigationDestination(
              icon: Icon(menu.icon),
              selectedIcon: Icon(menu.selectedIcon),
              label: menu.label(context),
            ),
          ),
        ],
      ),
    );
  }
}
