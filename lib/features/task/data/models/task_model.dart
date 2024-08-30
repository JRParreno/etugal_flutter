import 'package:etugal_flutter/features/task/data/models/index.dart';
import 'package:etugal_flutter/features/task/domain/entities/index.dart';

class TaskModel extends TaskEntity {
  TaskModel({
    required super.id,
    required super.taskCategory,
    required super.provider,
    required super.createdAt,
    required super.updatedAt,
    required super.title,
    required super.description,
    required super.workType,
    required super.reward,
    required super.address,
    required super.longitude,
    required super.latitude,
    required super.status,
    required super.rejectionReason,
    required super.performer,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json["id"],
      taskCategory: TaskCategoryModel.fromJson(json["task_category"]),
      provider: TaskUserProfileModel.fromJson(json["provider"]),
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
      title: json["title"],
      description: json["description"],
      workType: json["work_type"],
      reward: json["reward"],
      address: json["address"],
      longitude: json["longitude"],
      latitude: json["latitude"],
      status: json["status"],
      rejectionReason: json["rejection_reason"],
      performer: json["performer"] == null
          ? null
          : TaskUserProfileModel.fromJson(json["performer"]),
    );
  }
}
