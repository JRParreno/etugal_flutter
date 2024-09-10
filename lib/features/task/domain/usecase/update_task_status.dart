import 'package:etugal_flutter/core/error/failure.dart';
import 'package:etugal_flutter/core/usecase/usecase.dart';
import 'package:etugal_flutter/features/task/domain/repository/task_repository.dart';

import 'package:fpdart/fpdart.dart';

class UpdateTaskStatus implements UseCase<void, UpdateTaskStatusParams> {
  final TaskRepository taskRepository;

  const UpdateTaskStatus(this.taskRepository);

  @override
  Future<Either<Failure, void>> call(UpdateTaskStatusParams params) async {
    return await taskRepository.updateTaskStatus(
      taskId: params.taskId,
      taskStatus: params.taskStatus,
    );
  }
}

class UpdateTaskStatusParams {
  final String taskStatus;
  final int taskId;

  UpdateTaskStatusParams({
    required this.taskStatus,
    required this.taskId,
  });
}
