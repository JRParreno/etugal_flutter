part of 'task_detail_bloc.dart';

sealed class TaskDetailState extends Equatable {
  const TaskDetailState();

  @override
  List<Object?> get props => [];
}

final class TaskDetailInitial extends TaskDetailState {
  final int taskId;

  const TaskDetailInitial(this.taskId);

  @override
  List<Object?> get props => [taskId];
}

final class TaskDetailLoading extends TaskDetailState {}

final class TaskDetailSuccess extends TaskDetailState {}

final class TaskDetailFailure extends TaskDetailState {
  final String message;

  const TaskDetailFailure(this.message);

  @override
  List<Object> get props => [
        message,
      ];
}
