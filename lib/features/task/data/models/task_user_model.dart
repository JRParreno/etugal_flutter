import 'package:etugal_flutter/features/task/domain/entities/index.dart';

class TaskUserModel extends TaskUserEntity {
  TaskUserModel({
    required super.pk,
    required super.email,
    required super.firstName,
    required super.lastName,
    required super.username,
    required super.getFullName,
  });

  factory TaskUserModel.fromJson(Map<String, dynamic> json) {
    return TaskUserModel(
      pk: json["pk"],
      email: json["email"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      username: json["username"],
      getFullName: json["get_full_name"],
    );
  }
}
