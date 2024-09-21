part of 'my_task_detail_bloc.dart';

sealed class MyTaskDetailState extends Equatable {
  const MyTaskDetailState();

  @override
  List<Object?> get props => [];
}

final class MyTaskDetailInitial extends MyTaskDetailState {
  final TaskEntity? taskEntity;

  const MyTaskDetailInitial(this.taskEntity);

  MyTaskDetailInitial copyWith({
    TaskEntity? taskEntity,
  }) {
    return MyTaskDetailInitial(taskEntity ?? this.taskEntity);
  }

  @override
  List<Object?> get props => [taskEntity];
}

final class MyTaskDetailLoading extends MyTaskDetailState {}

final class MyTaskDetailSuccess extends MyTaskDetailState {
  final TaskStatusEnum? taskStatusEnum;
  final bool isAccept;

  const MyTaskDetailSuccess({
    this.isAccept = false,
    this.taskStatusEnum,
  });

  MyTaskDetailSuccess copyWith(
      {TaskStatusEnum? taskStatusEnum,
      bool? isAccept,
      TaskEntity? taskEntity}) {
    return MyTaskDetailSuccess(
      taskStatusEnum: taskStatusEnum ?? this.taskStatusEnum,
      isAccept: isAccept ?? this.isAccept,
    );
  }

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
