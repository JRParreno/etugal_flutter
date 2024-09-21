part of 'performer_task_list_bloc.dart';

sealed class PerformerTaskListEvent extends Equatable {
  const PerformerTaskListEvent();

  @override
  List<Object> get props => [];
}

final class GetPerformerTaskListTaskEvent extends PerformerTaskListEvent {
  final TaskStatusEnum taskStatus;
  final int index;

  const GetPerformerTaskListTaskEvent({
    required this.taskStatus,
    this.index = -1,
  });

  @override
  List<Object> get props => [
        taskStatus,
        index,
      ];
}

final class RefreshPerformerTaskListTaskEvent extends PerformerTaskListEvent {}

final class GetPerformerTaskListTaskPaginateEvent
    extends PerformerTaskListEvent {}

final class UpdateTaskEvent extends PerformerTaskListEvent {
  final TaskEntity task;

  const UpdateTaskEvent(this.task);

  @override
  List<Object> get props => [
        task,
      ];
}
