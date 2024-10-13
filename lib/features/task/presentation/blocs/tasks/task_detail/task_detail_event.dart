part of 'task_detail_bloc.dart';

sealed class TaskDetailEvent extends Equatable {
  const TaskDetailEvent();

  @override
  List<Object?> get props => [];
}

final class InitialTaskDetailEvent extends TaskDetailEvent {
  final int taskId;

  const InitialTaskDetailEvent(this.taskId);

  @override
  List<Object> get props => [taskId];
}

final class EasyApplyTaskDetailEvent extends TaskDetailEvent {
  final int performerId;
  final String? description;
  final int task;

  const EasyApplyTaskDetailEvent({
    required this.performerId,
    required this.task,
    this.description,
  });

  @override
  List<Object?> get props => [
        performerId,
        description,
        task,
      ];
}
