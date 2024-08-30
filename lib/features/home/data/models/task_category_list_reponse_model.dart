import 'package:etugal_flutter/features/home/domain/entities/index.dart';
import 'package:etugal_flutter/features/task/data/models/index.dart';

class TaskCategoryListResponseModel extends TaskCategoryListResponseEntity {
  TaskCategoryListResponseModel({
    required super.count,
    required super.next,
    required super.previous,
    required super.results,
  });

  factory TaskCategoryListResponseModel.fromJson(Map<String, dynamic> json) {
    return TaskCategoryListResponseModel(
      count: json["count"],
      next: json["next"],
      previous: json["previous"],
      results: json["results"] == null
          ? []
          : List<TaskCategoryModel>.from(
              json["results"]!.map((x) => TaskCategoryModel.fromJson(x))),
    );
  }
}
