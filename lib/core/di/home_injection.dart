import 'package:etugal_flutter/features/home/data/datasources/home_remote_data_source.dart';
import 'package:etugal_flutter/features/home/data/repository/home_task_repository_impl.dart';
import 'package:etugal_flutter/features/home/domain/repository/home_task_repository.dart';
import 'package:etugal_flutter/features/home/domain/usecase/index.dart';
import 'package:etugal_flutter/features/home/presentation/blocs/home_task/home_task_bloc.dart';
import 'package:etugal_flutter/features/home/presentation/blocs/home_task_category/home_task_category_bloc.dart';
import 'package:get_it/get_it.dart';

void initHome(GetIt serviceLocator) {
  serviceLocator
    // Datasource
    ..registerFactory<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(),
    )
    // Repository
    ..registerFactory<HomeTaskRepository>(
      () => HomeTaskRepositoryImpl(serviceLocator()),
    )
    // Usecase
    ..registerFactory(
      () => GetTaskCategoryList(serviceLocator()),
    )
    ..registerFactory(
      () => GetTaskList(serviceLocator()),
    )
    // Bloc
    ..registerFactory(
      () => HomeTaskBloc(serviceLocator()),
    )
    ..registerFactory(
      () => HomeTaskCategoryBloc(serviceLocator()),
    );
}
