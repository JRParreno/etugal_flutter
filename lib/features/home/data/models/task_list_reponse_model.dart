import 'package:etugal_flutter/features/home/domain/entities/index.dart';
import 'package:etugal_flutter/features/task/data/models/index.dart';

class TaskListResponseModel extends TaskListResponseEntity {
  TaskListResponseModel({
    required super.count,
    required super.next,
    required super.previous,
    required super.results,
  });

  factory TaskListResponseModel.fromJson(Map<String, dynamic> json) {
    return TaskListResponseModel(
      count: json["count"],
      next: json["next"],
      previous: json["previous"],
      results: json["results"] == null
          ? []
          : List<TaskModel>.from(
              json["results"]!.map((x) => TaskModel.fromJson(x))),
    );
  }
}
