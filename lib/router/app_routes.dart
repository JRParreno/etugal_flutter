/// Represents the app routes and their paths.
enum AppRoutes {
  onBoarding(
    name: 'on_boarding',
    path: '/on_boarding',
  ),
  login(
    name: 'login',
    path: '/login',
  ),
  signup(
    name: 'signup',
    path: '/signup',
  ),
  home(
    name: 'home',
    path: '/home',
  ),
  search(
    name: 'search',
    path: '/search',
  ),
  remedyDetail(
    name: 'remedy_detail',
    path: '/remedy_detail/:id',
  ),
  foodDetail(
    name: 'food_detail',
    path: '/food_detail/:id',
  ),
  deficiencyDetail(
    name: 'deficiency_detail',
    path: '/deficiency_detail/:id',
  ),
  profile(
    name: 'profile',
    path: '/profile',
  ),
  updateProfile(
    name: 'update_profile',
    path: 'update_profile',
  );

  const AppRoutes({
    required this.name,
    required this.path,
  });

  /// Represents the route name
  ///
  /// Example: `AppRoutes.splash.name`
  /// Returns: 'splash'
  final String name;

  /// Represents the route path
  ///
  /// Example: `AppRoutes.splash.path`
  /// Returns: '/splash'
  final String path;

  @override
  String toString() => name;
}
