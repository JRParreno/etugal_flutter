import 'package:etugal_flutter/features/task/domain/entities/index.dart';

class TaskReviewEntity {
  final int id;
  final TaskEntity task;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int providerRate;
  final String providerFeedback;
  final int performerRate;
  final String performerFeedback;

  TaskReviewEntity({
    required this.id,
    required this.task,
    required this.createdAt,
    required this.updatedAt,
    required this.providerRate,
    required this.providerFeedback,
    required this.performerRate,
    required this.performerFeedback,
  });
}
