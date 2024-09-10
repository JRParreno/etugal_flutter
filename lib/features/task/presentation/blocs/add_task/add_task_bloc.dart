import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:etugal_flutter/features/task/domain/usecase/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_task_event.dart';
part 'add_task_state.dart';

class AddTaskBloc extends Bloc<AddTaskEvent, AddTaskState> {
  final AddNewTask _addNewTask;

  AddTaskBloc(AddNewTask addNewTask)
      : _addNewTask = addNewTask,
        super(AddTaskInitial()) {
    on<SubmitAddTaskEvent>(onSubmitAddTaskEvent);
  }

  FutureOr<void> onSubmitAddTaskEvent(
      SubmitAddTaskEvent event, Emitter<AddTaskState> emit) async {
    emit(AddTaskLoading());

    final response = await _addNewTask.call(event.params);

    await Future.delayed(const Duration(seconds: 1));

    response.fold(
      (l) => emit(AddTaskFailure(l.message)),
      (r) => emit(AddTaskSuccess(r)),
    );
  }
}
