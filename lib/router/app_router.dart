import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:travel_guide/core/models/app_router_type.dart';
import 'package:travel_guide/core/providers/shared_preferences_provider.dart';

import '../features/explore/explore_page.dart';
import '../features/favorites/favorites_page.dart';
import '../features/home/home_page.dart';
import '../features/main_navigation_shell.dart';
import '../features/onboading/onboarding_view.dart';
import '../features/plan/plan_page.dart';
import '../features/profile/profile_page.dart';
import 'go_router_refresh_notifier.dart';

part 'app_router.g.dart';

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  final SharedPreferencesProvider preferences = ref.read(
    sharedPreferencesProvider,
  );
  final GoRouterRefreshNotifier refreshNotifier = GoRouterRefreshNotifier(
    listenable: preferences,
  );
  ref.onDispose(refreshNotifier.dispose);

  return GoRouter(
    initialLocation: AppRoute.home.path,
    refreshListenable: refreshNotifier,
    redirect: (BuildContext context, GoRouterState state) async {
      final bool isFirstLaunch = await preferences.isFirstLaunch();
      final String currentPath = state.matchedLocation;
      final bool isOnboarding = currentPath == AppRoute.onboarding.path;

      if (isFirstLaunch && !isOnboarding) {
        return AppRoute.onboarding.path;
      }

      if (!isFirstLaunch && isOnboarding) {
        return AppRoute.home.path;
      }

      return null;
    },
    routes: <RouteBase>[
      GoRoute(
        path: AppRoute.onboarding.path,
        name: AppRoute.onboarding.name,
        pageBuilder: (context, state) =>
            const NoTransitionPage<void>(child: OnboardingView()),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            MainNavigationShell(navigationShell: navigationShell),
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoute.home.path,
                name: AppRoute.home.name,
                pageBuilder: (context, state) =>
                    const NoTransitionPage<void>(child: HomePage()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoute.plan.path,
                name: AppRoute.plan.name,
                pageBuilder: (context, state) =>
                    const NoTransitionPage<void>(child: PlanPage()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoute.explore.path,
                name: AppRoute.explore.name,
                pageBuilder: (context, state) =>
                    const NoTransitionPage<void>(child: ExplorePage()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoute.favorites.path,
                name: AppRoute.favorites.name,
                pageBuilder: (context, state) =>
                    const NoTransitionPage<void>(child: FavoritesPage()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoute.profile.path,
                name: AppRoute.profile.name,
                pageBuilder: (context, state) =>
                    const NoTransitionPage<void>(child: ProfilePage()),
                routes: <RouteBase>[
                  GoRoute(
                    path: AppRoute.editLocation.path.split('/').last,
                    name: AppRoute.editLocation.name,
                    pageBuilder: (context, state) => const MaterialPage<void>(
                      child: OnboardingView(isEditing: true),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
