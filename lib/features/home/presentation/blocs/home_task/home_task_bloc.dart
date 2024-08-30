import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:etugal_flutter/core/usecase/usecase.dart';
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
    on<GetHomeTaskEvent>(onGetHomeTaskEvent);
    on<GetHomeTaskPaginateEvent>(onGetHomeTaskPaginateEvent);
  }

  FutureOr<void> onGetHomeTaskEvent(
      GetHomeTaskEvent event, Emitter<HomeTaskState> emit) async {
    emit(HomeTaskLoading());

    final response = await _getTaskList.call(const SearchParams(keyword: ''));

    response.fold(
      (l) => emit(HomeTaskFailure(l.message)),
      (r) => emit(HomeTaskSuccess(
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

        final response = await _getTaskList.call(SearchParams(
          keyword: '',
          previous: state.data.previous,
          next: state.data.next,
        ));

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
