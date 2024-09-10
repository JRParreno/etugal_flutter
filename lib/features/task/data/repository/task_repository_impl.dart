import 'package:etugal_flutter/core/enums/task_status_enum.dart';
import 'package:etugal_flutter/core/error/exceptions.dart';
import 'package:etugal_flutter/core/error/failure.dart';
import 'package:etugal_flutter/features/home/domain/entities/task_list_reponse_entity.dart';
import 'package:etugal_flutter/features/task/data/datasource/task_remote_data_source.dart';
import 'package:etugal_flutter/features/task/domain/repository/task_repository.dart';
import 'package:fpdart/fpdart.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource taskRemoteDataSource;

  TaskRepositoryImpl(this.taskRemoteDataSource);

  @override
  Future<Either<Failure, String>> addNewTask({
    required String title,
    required int taskCategory,
    required double reward,
    required String doneDate,
    required String scheduleTime,
    required String description,
    required String workType,
    required String address,
    required double longitude,
    required double latitude,
  }) async {
    try {
      final response = await taskRemoteDataSource.addNewTask(
        title: title,
        taskCategory: taskCategory,
        reward: reward,
        doneDate: doneDate,
        scheduleTime: scheduleTime,
        description: description,
        workType: workType,
        address: address,
        longitude: longitude,
        latitude: latitude,
      );

      return right(response);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TaskListResponseEntity>> getProviderTaskList(
      {required TaskStatusEnum taskStatus,
      String? previous,
      String? next}) async {
    try {
      final response = await taskRemoteDataSource.getProviderTaskList(
          taskStatus: taskStatus, next: next, previous: previous);

      return right(response);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
