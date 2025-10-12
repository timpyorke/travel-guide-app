import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../pages/explore_page.dart';
import '../pages/favorites_page.dart';
import '../pages/home_page.dart';
import '../pages/main_navigation_shell.dart';
import '../pages/profile_page.dart';

part 'app_router.g.dart';

enum AppRoute {
  home('/home'),
  explore('/explore'),
  favorites('/favorites'),
  profile('/profile');

  const AppRoute(this.path);

  final String path;
}

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  return GoRouter(
    initialLocation: AppRoute.home.path,
    routes: <RouteBase>[
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            MainNavigationShell(navigationShell: navigationShell),
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoute.home.path,
                name: AppRoute.home.name,
                pageBuilder: (context, state) => const NoTransitionPage<void>(
                  child: HomePage(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoute.explore.path,
                name: AppRoute.explore.name,
                pageBuilder: (context, state) => const NoTransitionPage<void>(
                  child: ExplorePage(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoute.favorites.path,
                name: AppRoute.favorites.name,
                pageBuilder: (context, state) => const NoTransitionPage<void>(
                  child: FavoritesPage(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoute.profile.path,
                name: AppRoute.profile.name,
                pageBuilder: (context, state) => const NoTransitionPage<void>(
                  child: ProfilePage(),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
