import 'package:flutter/material.dart';
import 'package:travel_guide/l10n/app_locale.dart';

enum MainNavigationMenu {
  home(
    icon: Icons.home_outlined,
    selectedIcon: Icons.home,
    labelKey: AppLocale.navHome,
  ),
  plan(
    icon: Icons.calendar_today_outlined,
    selectedIcon: Icons.calendar_today,
    labelKey: AppLocale.navPlan,
  ),
  explore(
    icon: Icons.explore_outlined,
    selectedIcon: Icons.explore,
    labelKey: AppLocale.navExplore,
  ),
  favorites(
    icon: Icons.favorite_outline,
    selectedIcon: Icons.favorite,
    labelKey: AppLocale.navFavorites,
  ),
  profile(
    icon: Icons.person_outline,
    selectedIcon: Icons.person,
    labelKey: AppLocale.navProfile,
  );

  const MainNavigationMenu({
    required this.icon,
    required this.selectedIcon,
    required this.labelKey,
  });

  final IconData icon;
  final IconData selectedIcon;
  final String labelKey;

  String label(BuildContext context) => labelKey.tr(context);
}
