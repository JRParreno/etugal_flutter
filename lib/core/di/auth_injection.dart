import 'package:etugal_flutter/core/common/cubits/cubit/app_user_cubit.dart';
import 'package:etugal_flutter/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:etugal_flutter/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:etugal_flutter/features/auth/domain/repository/auth_repository.dart';
import 'package:etugal_flutter/features/auth/domain/usecase/index.dart';
import 'package:etugal_flutter/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';

void initAuth(GetIt serviceLocator) {
  serviceLocator
    // Datasource
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(),
    )
    // Repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(serviceLocator()),
    )
    // Usecase
    ..registerFactory(
      () => UserSignup(serviceLocator()),
    )
    ..registerFactory(
      () => UserLogin(serviceLocator()),
    )
    ..registerFactory(
      () => CurrentUser(serviceLocator()),
    )
    // Bloc
    ..registerFactory(
      () => AuthBloc(
        currentUser: serviceLocator(),
        userLogin: serviceLocator(),
        userSignup: serviceLocator(),
        sharedPreferencesNotifier: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    )
    ..registerLazySingleton(() => AppUserCubit());
}
