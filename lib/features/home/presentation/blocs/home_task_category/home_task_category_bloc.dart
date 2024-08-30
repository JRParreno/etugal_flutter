import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:etugal_flutter/core/usecase/usecase.dart';
import 'package:etugal_flutter/features/home/domain/entities/index.dart';
import 'package:etugal_flutter/features/home/domain/usecase/index.dart';
import 'package:etugal_flutter/features/task/domain/entities/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_task_category_event.dart';
part 'home_task_category_state.dart';

class HomeTaskCategoryBloc
    extends Bloc<HomeTaskCategoryEvent, HomeTaskCategoryState> {
  final GetTaskCategoryList _getTaskCategoryList;

  HomeTaskCategoryBloc(GetTaskCategoryList getTaskCategoryList)
      : _getTaskCategoryList = getTaskCategoryList,
        super(HomeTaskCategoryInitial()) {
    on<GetHomeTaskCategoryEvent>(onGetHomeTaskEvent);
    on<GetHomeTaskCategoryPaginateEvent>(onGetHomeTaskPaginateEvent);
    on<OnTapHomeTaskCategoryEvent>(onTapHomeTaskCategoryEvent);
  }

  FutureOr<void> onTapHomeTaskCategoryEvent(OnTapHomeTaskCategoryEvent event,
      Emitter<HomeTaskCategoryState> emit) async {
    final state = this.state;

    if (state is HomeTaskCategorySuccess) {
      emit(state.copyWith(selected: event.index));
    }
  }

  FutureOr<void> onGetHomeTaskEvent(GetHomeTaskCategoryEvent event,
      Emitter<HomeTaskCategoryState> emit) async {
    emit(HomeTaskCategoryLoading());

    final response =
        await _getTaskCategoryList.call(const SearchParams(keyword: ''));

    response.fold(
      (l) => emit(HomeTaskCategoryFailure(l.message)),
      (r) => emit(HomeTaskCategorySuccess(
        data: r.copyWith(results: [TaskCategoryEntity.empty(), ...r.results]),
      )),
    );
  }

  FutureOr<void> onGetHomeTaskPaginateEvent(
      GetHomeTaskCategoryPaginateEvent event,
      Emitter<HomeTaskCategoryState> emit) async {
    final state = this.state;

    if (state is HomeTaskCategorySuccess) {
      if (state.data.next != null) {
        emit(state.copyWith(isPaginate: true));

        final response = await _getTaskCategoryList.call(SearchParams(
          keyword: '',
          previous: state.data.previous,
          next: state.data.next,
        ));

        response.fold(
          (l) => emit(HomeTaskCategoryFailure(l.message)),
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
