import 'package:etugal_flutter/core/error/failure.dart';
import 'package:etugal_flutter/core/usecase/usecase.dart';
import 'package:etugal_flutter/features/task/domain/entities/index.dart';
import 'package:etugal_flutter/features/task/domain/repository/task_repository.dart';

import 'package:fpdart/fpdart.dart';

class PerformerReview
    implements UseCase<TaskShortReviewEntity, PerformerReviewParams> {
  final TaskRepository taskRepository;

  const PerformerReview(this.taskRepository);

  @override
  Future<Either<Failure, TaskShortReviewEntity>> call(
      PerformerReviewParams params) async {
    return await taskRepository.performerReview(
      taskId: params.taskId,
      feedback: params.feedback,
      rate: params.rate,
    );
  }
}

class PerformerReviewParams {
  final int taskId;
  final String feedback;
  final int rate;

  PerformerReviewParams({
    required this.taskId,
    required this.feedback,
    required this.rate,
  });
}
