part of 'my_task_detail_bloc.dart';

sealed class MyTaskDetailState extends Equatable {
  const MyTaskDetailState();

  @override
  List<Object?> get props => [];
}

final class MyTaskDetailInitial extends MyTaskDetailState {
  final int taskId;

  const MyTaskDetailInitial(this.taskId);

  @override
  List<Object?> get props => [taskId];
}

final class MyTaskDetailLoading extends MyTaskDetailState {}

final class MyTaskDetailSuccess extends MyTaskDetailState {
  final TaskStatusEnum? taskStatusEnum;
  final bool isAccept;

  const MyTaskDetailSuccess({
    this.isAccept = false,
    this.taskStatusEnum,
  });

  @override
  List<Object?> get props => [
        isAccept,
        taskStatusEnum,
      ];
}

final class MyTaskDetailFailure extends MyTaskDetailState {
  final String message;

  const MyTaskDetailFailure(this.message);

  @override
  List<Object> get props => [
        message,
      ];
}
