import 'package:etugal_flutter/core/local_storage/shared_preferences_service.dart';
import 'package:etugal_flutter/core/notifier/shared_preferences_notifier.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> setupSharedPreferencesDependencies(GetIt serviceLocator) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  final sharedPreferencesService = SharedPreferencesService(sharedPreferences);
  final sharedPreferencesNotifier =
      SharedPreferencesNotifier(sharedPreferencesService);

  serviceLocator.registerLazySingleton<SharedPreferencesService>(
      () => sharedPreferencesService);
  serviceLocator.registerLazySingleton<SharedPreferencesNotifier>(
      () => sharedPreferencesNotifier);
}
