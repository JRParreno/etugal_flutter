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
  profile(
    name: 'profile',
    path: '/profile',
  ),
  updateProfile(
    name: 'update_profile',
    path: 'update_profile',
  ),
  uploadGovernmentId(
    name: 'upload-government-id',
    path: '/upload-government-id',
  ),
  uploadSelfie(
    name: 'upload-selfie',
    path: '/upload-selfie',
  ),
  processVerification(
    name: 'process-verification',
    path: '/process-verification',
  ),
  rejectVerification(
    name: 'reject-verification',
    path: '/reject-verification',
  ),
  addPostTask(
    name: 'add-task',
    path: '/add-task',
  ),
  taskDetail(
    name: 'task_detail',
    path: '/task_detail',
  ),
  myTaskList(
    name: 'my_task_list',
    path: '/my_task_list',
  ),
  myTaskDetail(
    name: 'my_task_detail',
    path: '/my_task_detail',
  ),
  ;

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
