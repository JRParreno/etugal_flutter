import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:etugal_flutter/features/task/domain/entities/index.dart';
import 'package:etugal_flutter/features/task/domain/usecase/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'task_provider_review_event.dart';
part 'task_provider_review_state.dart';

class TaskProviderReviewBloc
    extends Bloc<TaskProviderReviewEvent, TaskProviderReviewState> {
  final GetTaskProviderReview _getTaskProviderReview;

  TaskProviderReviewBloc(GetTaskProviderReview getTaskProviderReview)
      : _getTaskProviderReview = getTaskProviderReview,
        super(TaskProviderReviewInitial()) {
    on<GetTaskProviderReviewEvent>(onGetTaskProviderReviewEvent);
    on<PaginateTaskProviderReviewEvent>(onPaginateTaskProviderReviewEvent);
  }

  FutureOr<void> onGetTaskProviderReviewEvent(GetTaskProviderReviewEvent event,
      Emitter<TaskProviderReviewState> emit) async {
    emit(TaskProviderReviewLoading());

    final response = await _getTaskProviderReview
        .call(GetTaskProviderReviewParams(id: event.providerId));

    response.fold(
      (l) => emit(TaskProviderReviewFailure(l.message)),
      (r) => emit(TaskProviderReviewSuccess(data: r)),
    );
  }

  FutureOr<void> onPaginateTaskProviderReviewEvent(
      PaginateTaskProviderReviewEvent event,
      Emitter<TaskProviderReviewState> emit) async {
    final state = this.state;

    if (state is TaskProviderReviewSuccess) {
      if (state.data.next != null) {
        emit(state.copyWith(isPaginate: true));

        final response = await _getTaskProviderReview.call(
          GetTaskProviderReviewParams(
            id: event.providerId,
            next: state.data.next,
            previous: state.data.previous,
          ),
        );

        response.fold(
          (l) => emit(TaskProviderReviewFailure(l.message)),
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
