part of 'task_applicant_review_bloc.dart';

sealed class TaskApplicantReviewEvent extends Equatable {
  const TaskApplicantReviewEvent();

  @override
  List<Object> get props => [];
}

final class GetTaskApplicantReviewEvent extends TaskApplicantReviewEvent {
  final int performerId;

  const GetTaskApplicantReviewEvent(this.performerId);

  @override
  List<Object> get props => [performerId];
}

final class PaginateTaskApplicantReviewEvent extends TaskApplicantReviewEvent {
  final int performerId;

  const PaginateTaskApplicantReviewEvent(this.performerId);

  @override
  List<Object> get props => [performerId];
}
