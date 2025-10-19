enum AppRoute {
  onboarding(path: '/onboarding'),
  home(path: '/home'),
  plan(path: '/plan'),
  explore(path: '/explore'),
  favorites(path: '/favorites'),
  profile(path: '/profile'),
  editLocation(path: '/profile/edit-location');

  const AppRoute({required this.path});

  final String path;
}
