part of 'performer_task_list_bloc.dart';

sealed class PerformerTaskListState extends Equatable {
  const PerformerTaskListState();

  @override
  List<Object> get props => [];
}

final class PerformerTaskListInitial extends PerformerTaskListState {}

final class PerformerTaskListLoading extends PerformerTaskListState {
  final int index;
  const PerformerTaskListLoading({
    this.index = -1,
  });

  @override
  List<Object> get props => [index];
}

final class PerformerTaskListSuccess extends PerformerTaskListState {
  final TaskListResponseEntity data;
  final bool isPaginate;

  const PerformerTaskListSuccess({
    required this.data,
    this.isPaginate = false,
  });

  PerformerTaskListSuccess copyWith({
    TaskListResponseEntity? data,
    bool? isPaginate,
  }) {
    return PerformerTaskListSuccess(
      data: data ?? this.data,
      isPaginate: isPaginate ?? this.isPaginate,
    );
  }

  @override
  List<Object> get props => [data, isPaginate];
}

final class PerformerTaskListFailure extends PerformerTaskListState {
  final String message;

  const PerformerTaskListFailure(this.message);

  @override
  List<Object> get props => [
        message,
      ];
}
