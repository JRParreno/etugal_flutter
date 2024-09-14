import 'package:etugal_flutter/core/error/failure.dart';
import 'package:etugal_flutter/core/usecase/usecase.dart';
import 'package:etugal_flutter/features/task/domain/repository/task_repository.dart';

import 'package:fpdart/fpdart.dart';

class EasyApplyTask implements UseCase<void, EasyApplyTaskParams> {
  final TaskRepository taskRepository;

  const EasyApplyTask(this.taskRepository);

  @override
  Future<Either<Failure, void>> call(EasyApplyTaskParams params) async {
    return await taskRepository.easyApplyTask(
      performerId: params.performer,
      taskId: params.taskId,
      description: params.description,
    );
  }
}

class EasyApplyTaskParams {
  final int taskId;
  final int performer;
  final String? description;

  EasyApplyTaskParams({
    required this.taskId,
    required this.performer,
    required this.description,
  });
}
