import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:etugal_flutter/core/usecase/usecase.dart';
import 'package:etugal_flutter/features/home/domain/entities/index.dart';
import 'package:etugal_flutter/features/home/domain/usecase/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_task_category_event.dart';
part 'add_task_category_state.dart';

class AddTaskCategoryBloc
    extends Bloc<AddTaskCategoryEvent, AddTaskCategoryState> {
  final GetTaskCategoryList _getTaskCategoryList;

  AddTaskCategoryBloc(GetTaskCategoryList getTaskCategoryList)
      : _getTaskCategoryList = getTaskCategoryList,
        super(AddTaskCategoryInitial()) {
    on<GetAddTaskCategoryEvent>(onGetAddTaskEvent);
    on<GetTaskCategoryPaginateEvent>(onGetAddTaskPaginateEvent);
    on<OnTapAddTaskCategoryEvent>(onTapAddTaskCategoryEvent);
  }

  FutureOr<void> onTapAddTaskCategoryEvent(OnTapAddTaskCategoryEvent event,
      Emitter<AddTaskCategoryState> emit) async {
    final state = this.state;

    if (state is AddTaskCategorySuccess) {
      emit(state.copyWith(selected: event.index));
    }
  }

  FutureOr<void> onGetAddTaskEvent(
      GetAddTaskCategoryEvent event, Emitter<AddTaskCategoryState> emit) async {
    emit(AddTaskCategoryLoading());

    final response =
        await _getTaskCategoryList.call(const SearchParams(keyword: ''));

    response.fold(
      (l) => emit(AddTaskCategoryFailure(l.message)),
      (r) => emit(AddTaskCategorySuccess(data: r)),
    );
  }

  FutureOr<void> onGetAddTaskPaginateEvent(GetTaskCategoryPaginateEvent event,
      Emitter<AddTaskCategoryState> emit) async {
    final state = this.state;

    if (state is AddTaskCategorySuccess) {
      if (state.data.next != null) {
        emit(state.copyWith(isPaginate: true));

        final response = await _getTaskCategoryList.call(SearchParams(
          keyword: '',
          previous: state.data.previous,
          next: state.data.next,
        ));

        response.fold(
          (l) => emit(AddTaskCategoryFailure(l.message)),
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
