import 'package:etugal_flutter/features/task/data/models/index.dart';
import 'package:etugal_flutter/features/task/domain/entities/index.dart';

class TaskReviewModel extends TaskReviewEntity {
  TaskReviewModel({
    required super.id,
    required super.task,
    required super.createdAt,
    required super.updatedAt,
    required super.providerRate,
    required super.providerFeedback,
    required super.performerRate,
    required super.performerFeedback,
  });

  factory TaskReviewModel.fromMap(Map<String, dynamic> map) {
    return TaskReviewModel(
      id: map['id'] as int,
      task: TaskModel.fromJson(map['task']),
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
      providerRate: map['provider_rate'] as int,
      providerFeedback: map['provider_feedback'] as String,
      performerRate: map['performer_rate'] as int,
      performerFeedback: map['performer_feedback'] as String,
    );
  }

  factory TaskReviewModel.fromJson(Map<String, dynamic> map) {
    return TaskReviewModel(
      id: map['id'] as int,
      task: TaskModel.fromJson(map['task']),
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
      providerRate: map['provider_rate'] as int,
      providerFeedback: map['provider_feedback'] as String,
      performerRate: map['performer_rate'] as int,
      performerFeedback: map['performer_feedback'] as String,
    );
  }
}
