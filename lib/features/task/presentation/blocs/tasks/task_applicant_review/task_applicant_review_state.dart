part of 'task_applicant_review_bloc.dart';

sealed class TaskApplicantReviewState extends Equatable {
  const TaskApplicantReviewState();

  @override
  List<Object> get props => [];
}

final class TaskApplicantReviewInitial extends TaskApplicantReviewState {}

final class TaskApplicantReviewLoading extends TaskApplicantReviewState {}

final class TaskApplicantReviewSuccess extends TaskApplicantReviewState {
  final TaskReviewListEntity data;
  final bool isPaginate;

  const TaskApplicantReviewSuccess({
    required this.data,
    this.isPaginate = false,
  });

  TaskApplicantReviewSuccess copyWith({
    TaskReviewListEntity? data,
    bool? isPaginate,
  }) {
    return TaskApplicantReviewSuccess(
      data: data ?? this.data,
      isPaginate: isPaginate ?? this.isPaginate,
    );
  }

  @override
  List<Object> get props => [data, isPaginate];
}

final class TaskApplicantReviewFailure extends TaskApplicantReviewState {
  final String message;

  const TaskApplicantReviewFailure(this.message);

  @override
  List<Object> get props => [
        message,
      ];
}
