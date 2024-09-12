import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:etugal_flutter/core/enums/task_status_enum.dart';
import 'package:etugal_flutter/features/task/domain/usecase/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'my_task_detail_event.dart';
part 'my_task_detail_state.dart';

class MyTaskDetailBloc extends Bloc<MyTaskDetailEvent, MyTaskDetailState> {
  final SetTaskPerformer _setTaskPerformer;
  final UpdateTaskStatus _updateTaskStatus;

  MyTaskDetailBloc({
    required SetTaskPerformer setTaskPerformer,
    required UpdateTaskStatus updateTaskStatus,
  })  : _setTaskPerformer = setTaskPerformer,
        _updateTaskStatus = updateTaskStatus,
        super(const MyTaskDetailInitial(-1)) {
    on<InitialMyTaskDetailEvent>(onInitialMyTaskDetailEventl);
    on<AcceptMyTaskDetailEvent>(onAcceptMyTaskDetailEvent);
    on<UpdateStatusMyTaskDetailEvent>(onUpdateStatusMyTaskDetailEvent);
  }

  FutureOr<void> onInitialMyTaskDetailEventl(
      InitialMyTaskDetailEvent event, Emitter<MyTaskDetailState> emit) async {
    emit(MyTaskDetailInitial(event.taskId));
  }

  FutureOr<void> onAcceptMyTaskDetailEvent(
      AcceptMyTaskDetailEvent event, Emitter<MyTaskDetailState> emit) async {
    final state = this.state;

    if (state is MyTaskDetailInitial) {
      emit(MyTaskDetailLoading());

      final response = await _setTaskPerformer.call(
        SetTaskPerformerParams(
          performerId: event.performerId,
          taskId: state.taskId,
        ),
      );

      response.fold(
        (l) => emit(MyTaskDetailFailure(l.message)),
        (r) => emit(const MyTaskDetailSuccess(isAccept: true)),
      );
    }
  }

  FutureOr<void> onUpdateStatusMyTaskDetailEvent(
      UpdateStatusMyTaskDetailEvent event,
      Emitter<MyTaskDetailState> emit) async {
    final state = this.state;

    if (state is MyTaskDetailInitial) {
      emit(MyTaskDetailLoading());

      emit(MyTaskDetailLoading());

      final response = await _updateTaskStatus.call(
        UpdateTaskStatusParams(
          taskStatus: getTaskStatusFromEnum(event.taskStatus),
          taskId: state.taskId,
        ),
      );

      response.fold(
        (l) => emit(MyTaskDetailFailure(l.message)),
        (r) => emit(
          MyTaskDetailSuccess(taskStatusEnum: event.taskStatus),
        ),
      );
    }
  }
}
