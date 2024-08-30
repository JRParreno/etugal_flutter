import 'package:etugal_flutter/features/task/domain/entities/index.dart';

class TaskEntity {
  TaskEntity({
    required this.id,
    required this.taskCategory,
    required this.provider,
    required this.createdAt,
    required this.updatedAt,
    required this.title,
    required this.description,
    required this.workType,
    required this.reward,
    required this.address,
    required this.longitude,
    required this.latitude,
    required this.status,
    required this.rejectionReason,
    required this.performer,
  });

  final int id;
  final TaskCategoryEntity taskCategory;
  final TaskUserProfileEntity provider;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String title;
  final String description;
  final String workType;
  final double reward;
  final String address;
  final double longitude;
  final double latitude;
  final String status;
  final String? rejectionReason;
  final TaskUserProfileEntity? performer;
}
