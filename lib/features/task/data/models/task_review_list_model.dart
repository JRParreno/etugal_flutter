// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:etugal_flutter/features/task/data/models/index.dart';
import 'package:etugal_flutter/features/task/domain/entities/index.dart';

class TaskReviewListModel extends TaskReviewListEntity {
  TaskReviewListModel({
    required super.results,
    super.count,
    super.next,
    super.previous,
  });

  factory TaskReviewListModel.fromJson(Map<String, dynamic> json) {
    return TaskReviewListModel(
      count: json["count"],
      next: json["next"],
      previous: json["previous"],
      results: json["results"] == null
          ? []
          : List<TaskReviewModel>.from(
              json["results"]!.map((x) => TaskReviewModel.fromJson(x))),
    );
  }
}
