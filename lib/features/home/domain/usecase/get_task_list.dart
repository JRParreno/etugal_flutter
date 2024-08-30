import 'package:etugal_flutter/core/error/failure.dart';
import 'package:etugal_flutter/core/usecase/usecase.dart';
import 'package:etugal_flutter/features/home/domain/entities/index.dart';
import 'package:etugal_flutter/features/home/domain/repository/home_task_repository.dart';

import 'package:fpdart/fpdart.dart';

class GetTaskList
    implements UseCase<TaskListResponseEntity, GetTaskListParams> {
  final HomeTaskRepository homeTaskRepository;

  const GetTaskList(this.homeTaskRepository);

  @override
  Future<Either<Failure, TaskListResponseEntity>> call(
      GetTaskListParams params) async {
    return await homeTaskRepository.getTaskList(
      search: params.keyword,
      next: params.next,
      previous: params.previous,
      taskCategoryId: params.taskCategoryId,
    );
  }
}

class GetTaskListParams {
  final String keyword;
  final int? taskCategoryId;
  final String? next;
  final String? previous;

  const GetTaskListParams({
    required this.keyword,
    this.taskCategoryId,
    this.next,
    this.previous,
  });
}
