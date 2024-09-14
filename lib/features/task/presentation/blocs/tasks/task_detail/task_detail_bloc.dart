import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:etugal_flutter/features/task/domain/usecase/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'task_detail_event.dart';
part 'task_detail_state.dart';

class TaskDetailBloc extends Bloc<TaskDetailEvent, TaskDetailState> {
  final EasyApplyTask _easyApplyTask;

  TaskDetailBloc({
    required EasyApplyTask easyApplyTask,
  })  : _easyApplyTask = easyApplyTask,
        super(const TaskDetailInitial(-1)) {
    on<InitialTaskDetailEvent>(onInitialTaskDetailEventl);
    on<EasyApplyTaskDetailEvent>(onEasyApplyTaskDetailEvent);
  }

  FutureOr<void> onInitialTaskDetailEventl(
      InitialTaskDetailEvent event, Emitter<TaskDetailState> emit) async {
    emit(TaskDetailInitial(event.taskId));
    return;
  }

  FutureOr<void> onEasyApplyTaskDetailEvent(
      EasyApplyTaskDetailEvent event, Emitter<TaskDetailState> emit) async {
    final state = this.state;

    if (state is TaskDetailInitial) {
      emit(TaskDetailLoading());

      final response = await _easyApplyTask.call(
        EasyApplyTaskParams(
          taskId: state.taskId,
          performer: event.performerId,
          description: event.description,
        ),
      );

      response.fold(
        (l) => emit(TaskDetailFailure(l.message)),
        (r) => emit(TaskDetailSuccess()),
      );
    }
    return null;
  }
}
