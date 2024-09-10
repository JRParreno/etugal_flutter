import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:etugal_flutter/core/enums/task_status_enum.dart';
import 'package:etugal_flutter/features/home/domain/entities/index.dart';
import 'package:etugal_flutter/features/task/domain/usecase/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'provider_task_list_event.dart';
part 'provider_task_list_state.dart';

class ProviderTaskListBloc
    extends Bloc<ProviderTaskListEvent, ProviderTaskListState> {
  final GetProviderTaskList _getProviderTaskList;

  ProviderTaskListBloc({
    required GetProviderTaskList getProviderTaskList,
  })  : _getProviderTaskList = getProviderTaskList,
        super(ProviderTaskListInitial()) {
    on<GetProviderTaskListTaskEvent>(onGetProviderTaskListTaskEvent);
  }

  FutureOr<void> onGetProviderTaskListTaskEvent(
      GetProviderTaskListTaskEvent event,
      Emitter<ProviderTaskListState> emit) async {
    emit(ProviderTaskListLoading(index: event.index));

    final response = await _getProviderTaskList
        .call(GetProviderTaskListParams(taskStatus: event.taskStatus));

    await Future.delayed(const Duration(seconds: 1));

    response.fold(
      (l) => emit(ProviderTaskListFailure(l.message)),
      (r) => emit(ProviderTaskListSuccess(data: r)),
    );
  }

  FutureOr<void> onGetProviderTaskListTaskPaginateEvent(
      GetProviderTaskListTaskPaginateEvent event,
      Emitter<ProviderTaskListState> emit) async {
    final state = this.state;

    if (state is ProviderTaskListSuccess) {
      if (state.data.next != null) {
        emit(state.copyWith(isPaginate: true));

        final response = await _getProviderTaskList.call(
          GetProviderTaskListParams(
              next: state.data.next, previous: state.data.previous),
        );

        response.fold(
          (l) => emit(ProviderTaskListFailure(l.message)),
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
