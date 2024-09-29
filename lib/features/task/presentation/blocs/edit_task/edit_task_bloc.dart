import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:etugal_flutter/features/task/domain/usecase/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'edit_task_event.dart';
part 'edit_task_state.dart';

class EditTaskBloc extends Bloc<EditTaskEvent, EditTaskState> {
  final EditTask _editTask;

  EditTaskBloc(EditTask editTask)
      : _editTask = editTask,
        super(EditTaskInitial()) {
    on<SubmitEditTaskEvent>(onSubmitEditTaskEvent);
  }

  FutureOr<void> onSubmitEditTaskEvent(
      SubmitEditTaskEvent event, Emitter<EditTaskState> emit) async {
    emit(EditTaskLoading());

    final response = await _editTask.call(event.params);

    response.fold(
      (l) => emit(EditTaskFailure(l.message)),
      (r) => emit(EditTaskSuccess(r)),
    );
  }
}
