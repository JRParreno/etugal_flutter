import 'package:etugal_flutter/core/error/failure.dart';
import 'package:etugal_flutter/core/usecase/usecase.dart';
import 'package:etugal_flutter/features/home/domain/entities/index.dart';
import 'package:etugal_flutter/features/home/domain/repository/home_task_repository.dart';

import 'package:fpdart/fpdart.dart';

class GetTaskList implements UseCase<TaskListResponseEntity, SearchParams> {
  final HomeTaskRepository homeTaskRepository;

  const GetTaskList(this.homeTaskRepository);

  @override
  Future<Either<Failure, TaskListResponseEntity>> call(
      SearchParams params) async {
    return await homeTaskRepository.getTaskList(
      search: params.keyword,
      next: params.next,
      previous: params.previous,
    );
  }
}
