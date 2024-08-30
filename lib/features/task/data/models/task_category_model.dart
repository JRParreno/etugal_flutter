import 'package:etugal_flutter/features/task/domain/entities/index.dart';

class TaskCategoryModel extends TaskCategoryEntity {
  TaskCategoryModel({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required super.title,
  });

  factory TaskCategoryModel.fromJson(Map<String, dynamic> json) {
    return TaskCategoryModel(
      id: json["id"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
      title: json["title"],
    );
  }
}
