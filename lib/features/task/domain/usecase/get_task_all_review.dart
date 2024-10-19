import 'package:etugal_flutter/core/error/failure.dart';
import 'package:etugal_flutter/core/usecase/usecase.dart';
import 'package:etugal_flutter/features/task/domain/entities/index.dart';
import 'package:etugal_flutter/features/task/domain/repository/task_repository.dart';

import 'package:fpdart/fpdart.dart';

class GetTaskAllReview
    implements UseCase<TaskReviewListEntity, GetTaskAllReviewParams> {
  final TaskRepository taskRepository;

  const GetTaskAllReview(this.taskRepository);

  @override
  Future<Either<Failure, TaskReviewListEntity>> call(
      GetTaskAllReviewParams params) async {
    return await taskRepository.getTaskAllReview(
      next: params.next,
      previous: params.previous,
    );
  }
}

class GetTaskAllReviewParams {
  final String? next;
  final String? previous;

  const GetTaskAllReviewParams({
    this.next,
    this.previous,
  });
}
