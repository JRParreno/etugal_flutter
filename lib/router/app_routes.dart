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
  profileSettings(
    name: 'profile_settings',
    path: '/profile_settings',
  ),
  changePassword(
    name: 'change_password',
    path: '/change_password',
  ),
  changeProfilePhoto(
    name: 'change_profile_photo',
    path: '/change_profile_photo',
  ),
  updateProfile(
    name: 'update_profile',
    path: '/update_profile',
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
  myEditTaskDetail(
    name: 'my_edit_task_detail',
    path: '/my_edit_task_detail',
  ),
  performerTaskDetail(
    name: 'performer_task_detail',
    path: '/performer_task_detail',
  ),
  taskApplicantDetail(
    name: 'task_applicant_detail',
    path: '/task_applicant_detail',
  ),
  taskProviderDetail(
    name: 'task_provider_detail',
    path: '/task_provider_detail',
  ),
  chat(
    name: 'chat',
    path: '/chat',
  ),
  chatList(
    name: 'chat_list',
    path: '/chat_list',
  ),
  chatReportUser(
    name: 'chat_report_user',
    path: '/chat_report_user',
  ),
  forgotPassword(
    name: 'forgot_password',
    path: '/forgot_password',
  ),
  termsCondition(
    name: 'terms_condition',
    path: '/terms_condition',
  ),
  privacyPolicy(
    name: 'privacy_policy',
    path: '/privacy_policy',
  ),
  safetyGuide(
    name: 'safety_guide',
    path: '/safety_guide',
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
