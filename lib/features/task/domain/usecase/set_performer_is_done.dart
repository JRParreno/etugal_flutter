import 'package:etugal_flutter/core/error/failure.dart';
import 'package:etugal_flutter/core/usecase/usecase.dart';
import 'package:etugal_flutter/features/task/domain/entities/index.dart';
import 'package:etugal_flutter/features/task/domain/repository/task_repository.dart';

import 'package:fpdart/fpdart.dart';

class SetPerformerIsDone implements UseCase<TaskEntity, int> {
  final TaskRepository taskRepository;

  const SetPerformerIsDone(this.taskRepository);

  @override
  Future<Either<Failure, TaskEntity>> call(int params) async {
    return await taskRepository.setPerformIsDone(params);
  }
}
