import 'package:etugal_flutter/core/error/failure.dart';
import 'package:etugal_flutter/core/usecase/usecase.dart';
import 'package:etugal_flutter/features/task/domain/entities/index.dart';
import 'package:etugal_flutter/features/task/domain/repository/task_repository.dart';

import 'package:fpdart/fpdart.dart';

class GetTaskProviderReview
    implements UseCase<TaskReviewListEntity, GetTaskProviderReviewParams> {
  final TaskRepository taskRepository;

  const GetTaskProviderReview(this.taskRepository);

  @override
  Future<Either<Failure, TaskReviewListEntity>> call(
      GetTaskProviderReviewParams params) async {
    return await taskRepository.getTaskProviderReview(
      id: params.id,
      next: params.next,
      previous: params.previous,
    );
  }
}

class GetTaskProviderReviewParams {
  final int id;
  final String? next;
  final String? previous;

  const GetTaskProviderReviewParams({
    required this.id,
    this.next,
    this.previous,
  });
}
