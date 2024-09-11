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
    required String scheduleTime,
    required String description,
    required String workType,
    required String address,
    required double longitude,
    required double latitude,
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
}
