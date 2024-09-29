part of 'edit_task_bloc.dart';

sealed class EditTaskState extends Equatable {
  const EditTaskState();

  @override
  List<Object> get props => [];
}

final class EditTaskInitial extends EditTaskState {}

final class EditTaskLoading extends EditTaskState {}

final class EditTaskSuccess extends EditTaskState {
  final String message;

  const EditTaskSuccess(this.message);

  @override
  List<Object> get props => [
        message,
      ];
}

final class EditTaskFailure extends EditTaskState {
  final String message;

  const EditTaskFailure(this.message);

  @override
  List<Object> get props => [
        message,
      ];
}
