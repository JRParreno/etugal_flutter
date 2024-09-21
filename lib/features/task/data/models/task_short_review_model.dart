import 'package:etugal_flutter/features/task/domain/entities/index.dart';

class TaskShortReviewModel extends TaskShortReviewEntity {
  TaskShortReviewModel({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required super.providerRate,
    required super.providerFeedback,
    required super.performerRate,
    required super.performerFeedback,
  });

  factory TaskShortReviewModel.fromJson(Map<String, dynamic> json) {
    return TaskShortReviewModel(
      id: json['id'] as int,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      providerRate: json['provider_rate'] as int,
      providerFeedback: json['provider_feedback'] == null
          ? ''
          : json['provider_feedback'] as String,
      performerRate: json['performer_rate'] as int,
      performerFeedback: json['performer_feedback'] == null
          ? ''
          : json['performer_feedback'] as String,
    );
  }
}
