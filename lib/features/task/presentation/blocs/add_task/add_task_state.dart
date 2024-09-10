part of 'add_task_bloc.dart';

sealed class AddTaskState extends Equatable {
  const AddTaskState();

  @override
  List<Object> get props => [];
}

final class AddTaskInitial extends AddTaskState {}

final class AddTaskLoading extends AddTaskState {}

final class AddTaskSuccess extends AddTaskState {
  final String message;

  const AddTaskSuccess(this.message);

  @override
  List<Object> get props => [
        message,
      ];
}

final class AddTaskFailure extends AddTaskState {
  final String message;

  const AddTaskFailure(this.message);

  @override
  List<Object> get props => [
        message,
      ];
}
