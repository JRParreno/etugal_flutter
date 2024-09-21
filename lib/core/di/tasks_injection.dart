import 'package:etugal_flutter/features/task/domain/usecase/index.dart';
import 'package:etugal_flutter/features/task/presentation/blocs/cubit/review_star_cubit.dart';
import 'package:etugal_flutter/features/task/presentation/blocs/tasks/my_task_detail/my_task_detail_bloc.dart';
import 'package:etugal_flutter/features/task/presentation/blocs/tasks/performer_task_list/performer_task_list_bloc.dart';
import 'package:etugal_flutter/features/task/presentation/blocs/tasks/provider_task_list/provider_task_list_bloc.dart';
import 'package:etugal_flutter/features/task/presentation/blocs/tasks/task_applicant_review/task_applicant_review_bloc.dart';
import 'package:etugal_flutter/features/task/presentation/blocs/tasks/task_detail/task_detail_bloc.dart';
import 'package:etugal_flutter/features/task/presentation/blocs/tasks/task_provider_review/task_provider_review_bloc.dart';
import 'package:get_it/get_it.dart';

void initTasks(GetIt serviceLocator) {
  serviceLocator
    // Usecase
    ..registerFactory(
      () => GetProviderTaskList(serviceLocator()),
    )
    ..registerFactory(
      () => GetPerformerTaskList(serviceLocator()),
    )
    ..registerFactory(
      () => SetTaskPerformer(serviceLocator()),
    )
    ..registerFactory(
      () => UpdateTaskStatus(serviceLocator()),
    )
    ..registerFactory(
      () => GetTaskPerformerReview(serviceLocator()),
    )
    ..registerFactory(
      () => GetTaskProviderReview(serviceLocator()),
    )
    ..registerFactory(
      () => EasyApplyTask(serviceLocator()),
    )
    ..registerFactory(
      () => SetPerformerIsDone(serviceLocator()),
    )
    ..registerFactory(
      () => PerformerReview(serviceLocator()),
    )
    ..registerFactory(
      () => ProviderReview(serviceLocator()),
    )
    // Bloc
    ..registerFactory(
      () => ProviderTaskListBloc(getProviderTaskList: serviceLocator()),
    )
    ..registerFactory(
      () => PerformerTaskListBloc(getPerformerTaskList: serviceLocator()),
    )
    ..registerFactory(
      () => MyTaskDetailBloc(
        performerReview: serviceLocator(),
        providerReview: serviceLocator(),
        setPerformerIsDone: serviceLocator(),
        setTaskPerformer: serviceLocator(),
        updateTaskStatus: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => TaskDetailBloc(easyApplyTask: serviceLocator()),
    )
    ..registerFactory(
      () => TaskApplicantReviewBloc(serviceLocator()),
    )
    ..registerFactory(
      () => TaskProviderReviewBloc(serviceLocator()),
    )
    ..registerFactory(
      () => ReviewStarCubit(),
    );
}
