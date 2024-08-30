import 'package:etugal_flutter/core/error/failure.dart';
import 'package:etugal_flutter/core/usecase/usecase.dart';
import 'package:etugal_flutter/features/home/domain/entities/index.dart';
import 'package:etugal_flutter/features/home/domain/repository/home_task_repository.dart';

import 'package:fpdart/fpdart.dart';

class GetTaskCategoryList
    implements UseCase<TaskCategoryListResponseEntity, SearchParams> {
  final HomeTaskRepository homeTaskRepository;

  const GetTaskCategoryList(this.homeTaskRepository);

  @override
  Future<Either<Failure, TaskCategoryListResponseEntity>> call(
      SearchParams params) async {
    return await homeTaskRepository.getTaskCategoryList(
      search: params.keyword,
      next: params.next,
      previous: params.previous,
    );
  }
}
