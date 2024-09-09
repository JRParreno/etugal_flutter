import 'package:etugal_flutter/features/task/presentation/blocs/add_task_category/add_task_category_bloc.dart';
import 'package:get_it/get_it.dart';

void initAddPost(GetIt serviceLocator) {
  serviceLocator
      // // Datasource
      // ..registerFactory<HomeRemoteDataSource>(
      //   () => HomeRemoteDataSourceImpl(),
      // )
      // // Repository
      // ..registerFactory<HomeTaskRepository>(
      //   () => HomeTaskRepositoryImpl(serviceLocator()),
      // )
      // // Usecase
      // ..registerFactory(
      //   () => GetTaskCategoryList(serviceLocator()),
      // )
      // ..registerFactory(
      //   () => GetTaskList(serviceLocator()),
      // )
      // Bloc
      .registerFactory(
    () => AddTaskCategoryBloc(serviceLocator()),
  );
}
