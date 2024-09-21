import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:etugal_flutter/core/enums/task_status_enum.dart';
import 'package:etugal_flutter/core/error/failure.dart';
import 'package:etugal_flutter/features/task/domain/entities/index.dart';
import 'package:etugal_flutter/features/task/domain/usecase/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

part 'my_task_detail_event.dart';
part 'my_task_detail_state.dart';

class MyTaskDetailBloc extends Bloc<MyTaskDetailEvent, MyTaskDetailState> {
  final SetTaskPerformer _setTaskPerformer;
  final UpdateTaskStatus _updateTaskStatus;
  final SetPerformerIsDone _setPerformerIsDone;
  final ProviderReview _providerReview;
  final PerformerReview _performerReview;

  MyTaskDetailBloc({
    required SetTaskPerformer setTaskPerformer,
    required UpdateTaskStatus updateTaskStatus,
    required SetPerformerIsDone setPerformerIsDone,
    required ProviderReview providerReview,
    required PerformerReview performerReview,
  })  : _setTaskPerformer = setTaskPerformer,
        _updateTaskStatus = updateTaskStatus,
        _setPerformerIsDone = setPerformerIsDone,
        _providerReview = providerReview,
        _performerReview = performerReview,
        super(const MyTaskDetailInitial(null)) {
    on<InitialMyTaskDetailEvent>(onInitialMyTaskDetailEventl);
    on<AcceptMyTaskDetailEvent>(onAcceptMyTaskDetailEvent);
    on<UpdateStatusMyTaskDetailEvent>(onUpdateStatusMyTaskDetailEvent);
    on<SetPerformIsDoneTaskDetailEvent>(onSetPerformIsDoneTaskDetailEvent);
    on<AddFeedbackTaskDetailEvent>(onAddFeedbackTaskDetailEvent);
  }

  FutureOr<void> onInitialMyTaskDetailEventl(
      InitialMyTaskDetailEvent event, Emitter<MyTaskDetailState> emit) async {
    emit(MyTaskDetailInitial(event.taskEntity));
  }

  FutureOr<void> onAddFeedbackTaskDetailEvent(
      AddFeedbackTaskDetailEvent event, Emitter<MyTaskDetailState> emit) async {
    final state = this.state;

    if (state is MyTaskDetailInitial) {
      final task = state.taskEntity;

      if (task != null) {
        emit(MyTaskDetailLoading());
        Either<Failure, TaskShortReviewEntity> response;
        if (event.isProvider) {
          response = await _providerReview.call(
            ProviderReviewParams(
              taskId: task.id,
              feedback: event.feedback,
              rate: event.rate,
            ),
          );
        } else {
          response = await _performerReview.call(
            PerformerReviewParams(
              taskId: task.id,
              feedback: event.feedback,
              rate: event.rate,
            ),
          );
        }

        response.fold(
          (l) => emit(MyTaskDetailFailure(l.message)),
          (r) => emit(
            MyTaskDetailInitial(task.copyWith(review: r)),
          ),
        );
      }
    }
  }

  FutureOr<void> onAcceptMyTaskDetailEvent(
      AcceptMyTaskDetailEvent event, Emitter<MyTaskDetailState> emit) async {
    final state = this.state;

    if (state is MyTaskDetailInitial) {
      final task = state.taskEntity;

      if (task != null) {
        emit(MyTaskDetailLoading());

        final response = await _setTaskPerformer.call(
          SetTaskPerformerParams(
            performerId: event.performerId,
            taskId: task.id,
          ),
        );

        response.fold(
          (l) => emit(MyTaskDetailFailure(l.message)),
          (r) => emit(const MyTaskDetailSuccess(isAccept: true)),
        );
      }
    }
  }

  FutureOr<void> onUpdateStatusMyTaskDetailEvent(
      UpdateStatusMyTaskDetailEvent event,
      Emitter<MyTaskDetailState> emit) async {
    final state = this.state;

    if (state is MyTaskDetailInitial) {
      final task = state.taskEntity;

      if (task != null) {
        emit(MyTaskDetailLoading());

        final response = await _updateTaskStatus.call(
          UpdateTaskStatusParams(
            taskStatus: getTaskStatusFromEnum(event.taskStatus),
            taskId: task.id,
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

  FutureOr<void> onSetPerformIsDoneTaskDetailEvent(
      SetPerformIsDoneTaskDetailEvent event,
      Emitter<MyTaskDetailState> emit) async {
    final state = this.state;

    if (state is MyTaskDetailInitial) {
      final task = state.taskEntity;

      if (task != null) {
        emit(MyTaskDetailLoading());

        final response = await _setPerformerIsDone.call(task.id);

        response.fold(
          (l) => emit(MyTaskDetailFailure(l.message)),
          (r) => emit(
            MyTaskDetailInitial(r),
          ),
        );
      }
    }
  }
}
