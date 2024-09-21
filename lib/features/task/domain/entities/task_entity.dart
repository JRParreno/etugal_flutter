// ignore_for_file: public_member_api_docs, sort_constructors_first
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
    required this.doneDate,
    this.scheduleTime,
    this.performer,
    this.applicants,
    this.isDonePerform = false,
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
  final DateTime doneDate;
  final bool isDonePerform;
  final String? scheduleTime;
  final String? rejectionReason;
  final TaskUserProfileEntity? performer;
  final List<TaskUserProfileEntity>? applicants;

  TaskEntity copyWith({
    int? id,
    TaskCategoryEntity? taskCategory,
    TaskUserProfileEntity? provider,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? title,
    String? description,
    String? workType,
    double? reward,
    String? address,
    double? longitude,
    double? latitude,
    String? status,
    DateTime? doneDate,
    bool? isDonePerform,
    String? scheduleTime,
    String? rejectionReason,
    TaskUserProfileEntity? performer,
    List<TaskUserProfileEntity>? applicants,
  }) {
    return TaskEntity(
      id: id ?? this.id,
      taskCategory: taskCategory ?? this.taskCategory,
      provider: provider ?? this.provider,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      title: title ?? this.title,
      description: description ?? this.description,
      workType: workType ?? this.workType,
      reward: reward ?? this.reward,
      address: address ?? this.address,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      status: status ?? this.status,
      doneDate: doneDate ?? this.doneDate,
      isDonePerform: isDonePerform ?? this.isDonePerform,
      scheduleTime: scheduleTime ?? this.scheduleTime,
      rejectionReason: rejectionReason ?? this.rejectionReason,
      performer: performer ?? this.performer,
      applicants: applicants ?? this.applicants,
    );
  }
}
