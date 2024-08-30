// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:etugal_flutter/features/task/domain/entities/index.dart';

class TaskListResponseEntity {
  TaskListResponseEntity({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  final int? count;
  final String? next;
  final String? previous;
  final List<TaskEntity> results;

  TaskListResponseEntity copyWith({
    int? count,
    String? next,
    String? previous,
    List<TaskEntity>? results,
  }) {
    return TaskListResponseEntity(
      count: count ?? this.count,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      results: results ?? this.results,
    );
  }
}
