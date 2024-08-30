part of 'home_task_bloc.dart';

sealed class HomeTaskState extends Equatable {
  const HomeTaskState();

  @override
  List<Object> get props => [];
}

final class HomeTaskInitial extends HomeTaskState {}

final class HomeTaskLoading extends HomeTaskState {}

final class HomeTaskSuccess extends HomeTaskState {
  final TaskListResponseEntity data;
  final bool isPaginate;
  final String search;
  final int taskCategoryId;

  const HomeTaskSuccess({
    required this.data,
    required this.taskCategoryId,
    required this.search,
    this.isPaginate = false,
  });

  HomeTaskSuccess copyWith({
    TaskListResponseEntity? data,
    bool? isPaginate,
    int? taskCategoryId,
    String? search,
  }) {
    return HomeTaskSuccess(
      data: data ?? this.data,
      search: search ?? this.search,
      taskCategoryId: taskCategoryId ?? this.taskCategoryId,
      isPaginate: isPaginate ?? this.isPaginate,
    );
  }

  @override
  List<Object> get props => [
        data,
        isPaginate,
        taskCategoryId,
        search,
      ];
}

final class HomeTaskFailure extends HomeTaskState {
  final String message;

  const HomeTaskFailure(this.message);

  @override
  List<Object> get props => [
        message,
      ];
}
