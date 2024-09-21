import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:etugal_flutter/core/enums/task_status_enum.dart';
import 'package:etugal_flutter/features/home/domain/entities/index.dart';
import 'package:etugal_flutter/features/task/domain/entities/index.dart';
import 'package:etugal_flutter/features/task/domain/usecase/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'performer_task_list_event.dart';
part 'performer_task_list_state.dart';

class PerformerTaskListBloc
    extends Bloc<PerformerTaskListEvent, PerformerTaskListState> {
  final GetPerformerTaskList _getPerformerTaskList;

  PerformerTaskListBloc({
    required GetPerformerTaskList getPerformerTaskList,
  })  : _getPerformerTaskList = getPerformerTaskList,
        super(PerformerTaskListInitial()) {
    on<GetPerformerTaskListTaskEvent>(onGetPerformerTaskListTaskEvent,
        transformer: restartable());
    on<GetPerformerTaskListTaskPaginateEvent>(
        onGetPerformerTaskListTaskPaginateEvent,
        transformer: restartable());
    on<UpdateTaskEvent>(onUpdateTaskEvent, transformer: restartable());
  }

  FutureOr<void> onGetPerformerTaskListTaskEvent(
      GetPerformerTaskListTaskEvent event,
      Emitter<PerformerTaskListState> emit) async {
    emit(PerformerTaskListLoading(index: event.index));

    final response = await _getPerformerTaskList
        .call(GetPerformerTaskListParams(taskStatus: event.taskStatus));

    response.fold(
      (l) => emit(PerformerTaskListFailure(l.message)),
      (r) => emit(PerformerTaskListSuccess(data: r)),
    );
  }

  FutureOr<void> onUpdateTaskEvent(
      UpdateTaskEvent event, Emitter<PerformerTaskListState> emit) async {
    final state = this.state;
    if (state is PerformerTaskListSuccess) {
      final taskList = [...state.data.results];

      final index = taskList.indexWhere(
        (element) => element.id == event.task.id,
      );

      if (index > -1) {
        taskList[index] = event.task;
        emit(
          state.copyWith(
            data: state.data.copyWith(results: taskList),
          ),
        );
      }
    }
  }

  FutureOr<void> onGetPerformerTaskListTaskPaginateEvent(
      GetPerformerTaskListTaskPaginateEvent event,
      Emitter<PerformerTaskListState> emit) async {
    final state = this.state;

    if (state is PerformerTaskListSuccess) {
      if (state.data.next != null) {
        emit(state.copyWith(isPaginate: true));

        final response = await _getPerformerTaskList.call(
          GetPerformerTaskListParams(
              next: state.data.next, previous: state.data.previous),
        );

        response.fold(
          (l) => emit(PerformerTaskListFailure(l.message)),
          (r) => emit(
            state.copyWith(
              data: r.copyWith(
                results: [...state.data.results, ...r.results],
              ),
              isPaginate: false,
            ),
          ),
        );
      }
    }
  }
}
