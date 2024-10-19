import 'package:etugal_flutter/core/enums/task_status_enum.dart';
import 'package:etugal_flutter/core/error/failure.dart';
import 'package:etugal_flutter/features/home/domain/entities/index.dart';
import 'package:etugal_flutter/features/task/domain/entities/index.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class TaskRepository {
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
    String? scheduleTime,
  });
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
    String? scheduleTime,
  });
  Future<Either<Failure, TaskListResponseEntity>> getProviderTaskList({
    TaskStatusEnum? taskStatus,
    String? previous,
    String? next,
  });
  Future<Either<Failure, void>> setTaskPerformer({
    required int performerId,
    required int taskId,
  });
  Future<Either<Failure, void>> updateTaskStatus({
    required String taskStatus,
    required int taskId,
  });
  Future<Either<Failure, TaskReviewListEntity>> getTaskPerformerReview({
    required int id,
    String? previous,
    String? next,
  });
  Future<Either<Failure, TaskReviewListEntity>> getTaskProviderReview({
    required int id,
    String? previous,
    String? next,
  });
  Future<Either<Failure, TaskReviewListEntity>> getTaskAllReview({
    String? previous,
    String? next,
  });
  Future<Either<Failure, void>> easyApplyTask({
    required int performerId,
    required int taskId,
    String? description,
  });
  Future<Either<Failure, TaskListResponseEntity>> getPerformerTaskList({
    TaskStatusEnum? taskStatus,
    String? previous,
    String? next,
  });
  Future<Either<Failure, TaskEntity>> setPerformIsDone(int taskId);
  Future<Either<Failure, TaskShortReviewEntity>> providerReview({
    required int rate,
    required String feedback,
    required int taskId,
  });
  Future<Either<Failure, TaskShortReviewEntity>> performerReview({
    required int rate,
    required String feedback,
    required int taskId,
  });
}
