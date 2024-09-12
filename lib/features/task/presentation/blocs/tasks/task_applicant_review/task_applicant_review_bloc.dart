import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:etugal_flutter/features/task/domain/entities/index.dart';
import 'package:etugal_flutter/features/task/domain/usecase/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'task_applicant_review_event.dart';
part 'task_applicant_review_state.dart';

class TaskApplicantReviewBloc
    extends Bloc<TaskApplicantReviewEvent, TaskApplicantReviewState> {
  final GetTaskPerformerReview _getTaskPerformerReview;

  TaskApplicantReviewBloc(GetTaskPerformerReview getTaskPerformerReview)
      : _getTaskPerformerReview = getTaskPerformerReview,
        super(TaskApplicantReviewInitial()) {
    on<GetTaskApplicantReviewEvent>(onGetTaskApplicantReviewEvent);
    on<PaginateTaskApplicantReviewEvent>(onPaginateTaskApplicantReviewEvent);
  }

  FutureOr<void> onGetTaskApplicantReviewEvent(
      GetTaskApplicantReviewEvent event,
      Emitter<TaskApplicantReviewState> emit) async {
    emit(TaskApplicantReviewLoading());

    final response = await _getTaskPerformerReview
        .call(GetTaskPerformerReviewParams(id: event.performerId));

    response.fold(
      (l) => emit(TaskApplicantReviewFailure(l.message)),
      (r) => emit(TaskApplicantReviewSuccess(data: r)),
    );
  }

  FutureOr<void> onPaginateTaskApplicantReviewEvent(
      PaginateTaskApplicantReviewEvent event,
      Emitter<TaskApplicantReviewState> emit) async {
    final state = this.state;

    if (state is TaskApplicantReviewSuccess) {
      if (state.data.next != null) {
        emit(state.copyWith(isPaginate: true));

        final response = await _getTaskPerformerReview.call(
          GetTaskPerformerReviewParams(
            id: event.performerId,
            next: state.data.next,
            previous: state.data.previous,
          ),
        );

        response.fold(
          (l) => emit(TaskApplicantReviewFailure(l.message)),
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
