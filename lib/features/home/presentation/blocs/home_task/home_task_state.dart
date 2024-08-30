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

  const HomeTaskSuccess({
    required this.data,
    this.isPaginate = false,
  });

  HomeTaskSuccess copyWith({
    TaskListResponseEntity? data,
    bool? isPaginate,
  }) {
    return HomeTaskSuccess(
      data: data ?? this.data,
      isPaginate: isPaginate ?? this.isPaginate,
    );
  }

  @override
  List<Object> get props => [
        data,
        isPaginate,
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
