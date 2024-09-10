part of 'add_task_bloc.dart';

sealed class AddTaskEvent extends Equatable {
  const AddTaskEvent();

  @override
  List<Object> get props => [];
}

final class SubmitAddTaskEvent extends AddTaskEvent {
  final AddNewTaskParams params;

  const SubmitAddTaskEvent(this.params);

  @override
  List<Object> get props => [params];
}
