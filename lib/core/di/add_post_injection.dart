import 'package:etugal_flutter/features/task/data/datasource/task_remote_data_source.dart';
import 'package:etugal_flutter/features/task/data/repository/task_repository_impl.dart';
import 'package:etugal_flutter/features/task/domain/repository/task_repository.dart';
import 'package:etugal_flutter/features/task/domain/usecase/index.dart';
import 'package:etugal_flutter/features/task/presentation/blocs/add_task/add_task_bloc.dart';
import 'package:etugal_flutter/features/task/presentation/blocs/add_task_category/add_task_category_bloc.dart';
import 'package:get_it/get_it.dart';

void initAddPost(GetIt serviceLocator) {
  serviceLocator
    // Datasource
    ..registerFactory<TaskRemoteDataSource>(
      () => TaskRemoteDataSourceImpl(),
    )
    // Repository
    ..registerFactory<TaskRepository>(
      () => TaskRepositoryImpl(serviceLocator()),
    )
    // Usecase
    ..registerFactory(
      () => AddNewTask(serviceLocator()),
    )
    // Bloc
    ..registerFactory(
      () => AddTaskCategoryBloc(serviceLocator()),
    )
    ..registerFactory(
      () => AddTaskBloc(serviceLocator()),
    );
}
