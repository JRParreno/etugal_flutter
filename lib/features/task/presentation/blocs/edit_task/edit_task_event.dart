part of 'edit_task_bloc.dart';

sealed class EditTaskEvent extends Equatable {
  const EditTaskEvent();

  @override
  List<Object> get props => [];
}

final class SubmitEditTaskEvent extends EditTaskEvent {
  final EditTaskParams params;

  const SubmitEditTaskEvent(this.params);

  @override
  List<Object> get props => [params];
}
