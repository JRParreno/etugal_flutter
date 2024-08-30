import 'package:etugal_flutter/core/error/failure.dart';
import 'package:etugal_flutter/features/home/domain/entities/index.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class HomeTaskRepository {
  Future<Either<Failure, TaskCategoryListResponseEntity>> getTaskCategoryList({
    String? previous,
    String? next,
    String? search,
  });
  Future<Either<Failure, TaskListResponseEntity>> getTaskList({
    String? previous,
    String? next,
    String? search,
  });
}
