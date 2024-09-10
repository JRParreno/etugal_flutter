part of 'my_task_detail_bloc.dart';

sealed class MyTaskDetailEvent extends Equatable {
  const MyTaskDetailEvent();

  @override
  List<Object> get props => [];
}

final class InitialMyTaskDetailEvent extends MyTaskDetailEvent {
  final int taskId;

  const InitialMyTaskDetailEvent(this.taskId);

  @override
  List<Object> get props => [taskId];
}

final class AcceptMyTaskDetailEvent extends MyTaskDetailEvent {
  final int performerId;

  const AcceptMyTaskDetailEvent(this.performerId);

  @override
  List<Object> get props => [performerId];
}

final class UpdateStatusMyTaskDetailEvent extends MyTaskDetailEvent {
  final TaskStatusEnum taskStatus;

  const UpdateStatusMyTaskDetailEvent(this.taskStatus);

  @override
  List<Object> get props => [taskStatus];
}
