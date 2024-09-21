import 'package:etugal_flutter/core/error/failure.dart';
import 'package:etugal_flutter/core/usecase/usecase.dart';
import 'package:etugal_flutter/features/task/domain/entities/index.dart';
import 'package:etugal_flutter/features/task/domain/repository/task_repository.dart';

import 'package:fpdart/fpdart.dart';

class ProviderReview
    implements UseCase<TaskShortReviewEntity, ProviderReviewParams> {
  final TaskRepository taskRepository;

  const ProviderReview(this.taskRepository);

  @override
  Future<Either<Failure, TaskShortReviewEntity>> call(
      ProviderReviewParams params) async {
    return await taskRepository.providerReview(
      taskId: params.taskId,
      feedback: params.feedback,
      rate: params.rate,
    );
  }
}

class ProviderReviewParams {
  final int taskId;
  final String feedback;
  final int rate;

  ProviderReviewParams({
    required this.taskId,
    required this.feedback,
    required this.rate,
  });
}
