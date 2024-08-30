import 'package:etugal_flutter/core/error/exceptions.dart';
import 'package:etugal_flutter/core/error/failure.dart';
import 'package:etugal_flutter/features/home/data/datasources/home_remote_data_source.dart';
import 'package:etugal_flutter/features/home/domain/entities/index.dart';
import 'package:etugal_flutter/features/home/domain/repository/home_task_repository.dart';
import 'package:fpdart/fpdart.dart';

class HomeTaskRepositoryImpl implements HomeTaskRepository {
  final HomeRemoteDataSource homeRemoteDataSource;

  HomeTaskRepositoryImpl(this.homeRemoteDataSource);

  @override
  Future<Either<Failure, TaskCategoryListResponseEntity>> getTaskCategoryList({
    String? previous,
    String? next,
    String? search,
  }) async {
    try {
      final response = await homeRemoteDataSource.getTaskCategoryList(
        search: search,
        next: next,
        previous: previous,
      );

      return right(response);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TaskListResponseEntity>> getTaskList({
    int? taskCategoryId,
    String? previous,
    String? next,
    String? search,
  }) async {
    try {
      final response = await homeRemoteDataSource.getTaskList(
        search: search,
        next: next,
        previous: previous,
        taskCategoryId: taskCategoryId,
      );

      return right(response);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
