import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:etugal_flutter/features/home/domain/entities/index.dart';
import 'package:etugal_flutter/features/home/domain/usecase/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_task_event.dart';
part 'home_task_state.dart';

class HomeTaskBloc extends Bloc<HomeTaskEvent, HomeTaskState> {
  final GetTaskList _getTaskList;

  HomeTaskBloc(GetTaskList getTaskList)
      : _getTaskList = getTaskList,
        super(HomeTaskInitial()) {
    on<GetHomeTaskEvent>(onGetHomeTaskEvent, transformer: restartable());
    on<GetHomeTaskPaginateEvent>(onGetHomeTaskPaginateEvent,
        transformer: restartable());
  }

  FutureOr<void> onGetHomeTaskEvent(
      GetHomeTaskEvent event, Emitter<HomeTaskState> emit) async {
    emit(HomeTaskLoading());

    final response = await _getTaskList.call(
      GetTaskListParams(
        keyword: event.search,
        taskCategoryId:
            event.taskCategoryId == -1 ? null : event.taskCategoryId,
      ),
    );

    await Future.delayed(const Duration(seconds: 1));

    response.fold(
      (l) => emit(HomeTaskFailure(l.message)),
      (r) => emit(HomeTaskSuccess(
        search: event.search,
        taskCategoryId: event.taskCategoryId,
        data: r,
      )),
    );
  }

  FutureOr<void> onGetHomeTaskPaginateEvent(
      GetHomeTaskPaginateEvent event, Emitter<HomeTaskState> emit) async {
    final state = this.state;

    if (state is HomeTaskSuccess) {
      if (state.data.next != null) {
        emit(state.copyWith(isPaginate: true));

        final response = await _getTaskList.call(GetTaskListParams(
            keyword: state.search,
            previous: state.data.previous,
            next: state.data.next,
            taskCategoryId: state.taskCategoryId));

        response.fold(
          (l) => emit(HomeTaskFailure(l.message)),
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
