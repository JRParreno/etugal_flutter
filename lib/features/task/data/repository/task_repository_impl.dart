import 'package:etugal_flutter/core/enums/task_status_enum.dart';
import 'package:etugal_flutter/core/error/failure.dart';
import 'package:etugal_flutter/features/home/domain/entities/task_list_reponse_entity.dart';
import 'package:etugal_flutter/features/task/data/datasource/task_remote_data_source.dart';
import 'package:etugal_flutter/features/task/domain/entities/task_entity.dart';
import 'package:etugal_flutter/features/task/domain/entities/task_review_list_entity.dart';
import 'package:etugal_flutter/features/task/domain/entities/task_short_review_entity.dart';
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
    required String description,
    required String workType,
    required String address,
    required double longitude,
    required double latitude,
    required int numWorker,
    String? scheduleTime,
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
        numWorker: numWorker,
      );

      return right(response);
    } on Failure catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Failure, TaskListResponseEntity>> getProviderTaskList(
      {TaskStatusEnum? taskStatus, String? previous, String? next}) async {
    try {
      final response = await taskRemoteDataSource.getProviderTaskList(
          taskStatus: taskStatus, next: next, previous: previous);

      return right(response);
    } on Failure catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Failure, void>> setTaskPerformer({
    required int performerId,
    required int taskId,
  }) async {
    try {
      final response = await taskRemoteDataSource.setTaskPerformer(
        performerId: performerId,
        taskId: taskId,
      );
      return right(response);
    } on Failure catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Failure, void>> updateTaskStatus({
    required String taskStatus,
    required int taskId,
  }) async {
    try {
      final response = await taskRemoteDataSource.updateTaskStatus(
        taskId: taskId,
        taskStatus: taskStatus,
      );
      return right(response);
    } on Failure catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Failure, TaskReviewListEntity>> getTaskPerformerReview(
      {required int id, String? previous, String? next}) async {
    try {
      final response = await taskRemoteDataSource.getTaskPerformerReview(
        id: id,
        next: next,
        previous: previous,
      );

      return right(response);
    } on Failure catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Failure, TaskReviewListEntity>> getTaskProviderReview(
      {required int id, String? previous, String? next}) async {
    try {
      final response = await taskRemoteDataSource.getTaskProviderReview(
        id: id,
        next: next,
        previous: previous,
      );

      return right(response);
    } on Failure catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Failure, void>> easyApplyTask({
    required int performerId,
    required int taskId,
    String? description,
  }) async {
    try {
      final response = await taskRemoteDataSource.easyApplyTask(
        performerId: performerId,
        taskId: taskId,
        description: description,
      );
      return right(response);
    } on Failure catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Failure, TaskListResponseEntity>> getPerformerTaskList({
    TaskStatusEnum? taskStatus,
    String? previous,
    String? next,
  }) async {
    try {
      final response = await taskRemoteDataSource.getPerformerTaskList(
          taskStatus: taskStatus, next: next, previous: previous);

      return right(response);
    } on Failure catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Failure, TaskEntity>> setPerformIsDone(int taskId) async {
    try {
      final response = await taskRemoteDataSource.setPerformIsDone(taskId);
      return right(response);
    } on Failure catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Failure, TaskShortReviewEntity>> performerReview({
    required int rate,
    required String feedback,
    required int taskId,
  }) async {
    try {
      final response = await taskRemoteDataSource.performerReview(
        feedback: feedback,
        rate: rate,
        taskId: taskId,
      );
      return right(response);
    } on Failure catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Failure, TaskShortReviewEntity>> providerReview({
    required int rate,
    required String feedback,
    required int taskId,
  }) async {
    try {
      final response = await taskRemoteDataSource.providerReview(
        feedback: feedback,
        rate: rate,
        taskId: taskId,
      );
      return right(response);
    } on Failure catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Failure, String>> editTask({
    required int taskId,
    required String title,
    required int taskCategory,
    required double reward,
    required String doneDate,
    required String description,
    required String workType,
    required String address,
    required double longitude,
    required double latitude,
    required int numWorker,
    String? scheduleTime,
  }) async {
    try {
      final response = await taskRemoteDataSource.editTask(
        taskId: taskId,
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
        numWorker: numWorker,
      );

      return right(response);
    } on Failure catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<Failure, TaskReviewListEntity>> getTaskAllReview(
      {String? previous, String? next}) async {
    try {
      final response = await taskRemoteDataSource.getTaskAllReview(
        next: next,
        previous: previous,
      );
      return right(response);
    } on Failure catch (e) {
      return left(e);
    }
  }
}
