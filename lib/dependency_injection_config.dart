import 'package:etugal_flutter/core/di/index.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  // set authentication feature
  initAuth(serviceLocator);
  // Shared preferences
  await setupSharedPreferencesDependencies(serviceLocator);
}
