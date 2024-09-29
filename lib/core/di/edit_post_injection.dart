import 'package:etugal_flutter/features/task/domain/usecase/index.dart';
import 'package:etugal_flutter/features/task/presentation/blocs/edit_task/edit_task_bloc.dart';
import 'package:get_it/get_it.dart';

void initEditPost(GetIt serviceLocator) {
  serviceLocator
    // Usecase
    ..registerFactory(
      () => EditTask(serviceLocator()),
    )
    ..registerFactory(
      () => EditTaskBloc(serviceLocator()),
    );
}
