import 'package:etugal_flutter/core/enums/task_status_enum.dart';
import 'package:etugal_flutter/core/error/failure.dart';
import 'package:etugal_flutter/core/usecase/usecase.dart';
import 'package:etugal_flutter/features/home/domain/entities/index.dart';
import 'package:etugal_flutter/features/task/domain/repository/task_repository.dart';

import 'package:fpdart/fpdart.dart';

class GetProviderTaskList
    implements UseCase<TaskListResponseEntity, GetProviderTaskListParams> {
  final TaskRepository taskRepository;

  const GetProviderTaskList(this.taskRepository);

  @override
  Future<Either<Failure, TaskListResponseEntity>> call(
      GetProviderTaskListParams params) async {
    return await taskRepository.getProviderTaskList(
      taskStatus: params.taskStatus,
      next: params.next,
      previous: params.previous,
    );
  }
}

class GetProviderTaskListParams {
  final TaskStatusEnum? taskStatus;
  final String? previous;
  final String? next;

  GetProviderTaskListParams({
    this.taskStatus,
    this.previous,
    this.next,
  });
}
