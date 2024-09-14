import 'package:etugal_flutter/core/enums/task_status_enum.dart';
import 'package:etugal_flutter/core/error/failure.dart';
import 'package:etugal_flutter/core/usecase/usecase.dart';
import 'package:etugal_flutter/features/home/domain/entities/index.dart';
import 'package:etugal_flutter/features/task/domain/repository/task_repository.dart';

import 'package:fpdart/fpdart.dart';

class GetPerformerTaskList
    implements UseCase<TaskListResponseEntity, GetPerformerTaskListParams> {
  final TaskRepository taskRepository;

  const GetPerformerTaskList(this.taskRepository);

  @override
  Future<Either<Failure, TaskListResponseEntity>> call(
      GetPerformerTaskListParams params) async {
    return await taskRepository.getPerformerTaskList(
      taskStatus: params.taskStatus,
      next: params.next,
      previous: params.previous,
    );
  }
}

class GetPerformerTaskListParams {
  final TaskStatusEnum? taskStatus;
  final String? previous;
  final String? next;

  GetPerformerTaskListParams({
    this.taskStatus,
    this.previous,
    this.next,
  });
}
