import 'package:etugal_flutter/core/di/index.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  // set authentication feature
  initAuth(serviceLocator);
  // Shared preferences
  await setupSharedPreferencesDependencies(serviceLocator);

  // Home
  initHome(serviceLocator);
  // Profile
  initProfile(serviceLocator);
  // Add Post
  initAddPost(serviceLocator);
// Edit Post
  initEditPost(serviceLocator);
  // Tasks
  initTasks(serviceLocator);
  // Chat
  initChat(serviceLocator);
}
