import 'package:etugal_flutter/core/error/failure.dart';
import 'package:etugal_flutter/core/usecase/usecase.dart';
import 'package:etugal_flutter/features/task/domain/entities/index.dart';
import 'package:etugal_flutter/features/task/domain/repository/task_repository.dart';

import 'package:fpdart/fpdart.dart';

class GetTaskPerformerReview
    implements UseCase<TaskReviewListEntity, GetTaskPerformerReviewParams> {
  final TaskRepository taskRepository;

  const GetTaskPerformerReview(this.taskRepository);

  @override
  Future<Either<Failure, TaskReviewListEntity>> call(
      GetTaskPerformerReviewParams params) async {
    return await taskRepository.getTaskPerformerReview(
      id: params.id,
      next: params.next,
      previous: params.previous,
    );
  }
}

class GetTaskPerformerReviewParams {
  final int id;
  final String? next;
  final String? previous;

  const GetTaskPerformerReviewParams({
    required this.id,
    this.next,
    this.previous,
  });
}
