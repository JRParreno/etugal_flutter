part of 'my_task_detail_bloc.dart';

sealed class MyTaskDetailEvent extends Equatable {
  const MyTaskDetailEvent();

  @override
  List<Object> get props => [];
}

final class InitialMyTaskDetailEvent extends MyTaskDetailEvent {
  final TaskEntity taskEntity;

  const InitialMyTaskDetailEvent(this.taskEntity);

  @override
  List<Object> get props => [taskEntity];
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

final class SetPerformIsDoneTaskDetailEvent extends MyTaskDetailEvent {}

final class AddFeedbackTaskDetailEvent extends MyTaskDetailEvent {
  final bool isProvider;
  final String feedback;
  final int rate;

  const AddFeedbackTaskDetailEvent(
      {required this.feedback, required this.rate, this.isProvider = true});

  @override
  List<Object> get props => [
        isProvider,
        rate,
        feedback,
      ];
}
