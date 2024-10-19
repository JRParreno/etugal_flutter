part of 'task_provider_review_bloc.dart';

sealed class TaskProviderReviewEvent extends Equatable {
  const TaskProviderReviewEvent();

  @override
  List<Object> get props => [];
}

final class GetTaskProviderReviewEvent extends TaskProviderReviewEvent {
  final int providerId;

  const GetTaskProviderReviewEvent(this.providerId);

  @override
  List<Object> get props => [providerId];
}

final class GetTaskAllReviewEvent extends TaskProviderReviewEvent {}

final class PaginateTaskProviderReviewEvent extends TaskProviderReviewEvent {
  final int providerId;

  const PaginateTaskProviderReviewEvent(this.providerId);

  @override
  List<Object> get props => [providerId];
}
