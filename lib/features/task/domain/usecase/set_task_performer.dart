import 'package:etugal_flutter/core/error/failure.dart';
import 'package:etugal_flutter/core/usecase/usecase.dart';
import 'package:etugal_flutter/features/task/domain/repository/task_repository.dart';

import 'package:fpdart/fpdart.dart';

class SetTaskPerformer implements UseCase<void, SetTaskPerformerParams> {
  final TaskRepository taskRepository;

  const SetTaskPerformer(this.taskRepository);

  @override
  Future<Either<Failure, void>> call(SetTaskPerformerParams params) async {
    return await taskRepository.setTaskPerformer(
      performerId: params.performerId,
      taskId: params.taskId,
    );
  }
}

class SetTaskPerformerParams {
  final int taskId;
  final int performerId;

  SetTaskPerformerParams({
    required this.taskId,
    required this.performerId,
  });
}
