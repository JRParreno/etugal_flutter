part of 'task_provider_review_bloc.dart';

sealed class TaskProviderReviewState extends Equatable {
  const TaskProviderReviewState();

  @override
  List<Object> get props => [];
}

final class TaskProviderReviewInitial extends TaskProviderReviewState {}

final class TaskProviderReviewLoading extends TaskProviderReviewState {}

final class TaskProviderReviewSuccess extends TaskProviderReviewState {
  final TaskReviewListEntity data;
  final bool isPaginate;

  const TaskProviderReviewSuccess({
    required this.data,
    this.isPaginate = false,
  });

  TaskProviderReviewSuccess copyWith({
    TaskReviewListEntity? data,
    bool? isPaginate,
  }) {
    return TaskProviderReviewSuccess(
      data: data ?? this.data,
      isPaginate: isPaginate ?? this.isPaginate,
    );
  }

  @override
  List<Object> get props => [data, isPaginate];
}

final class TaskProviderReviewFailure extends TaskProviderReviewState {
  final String message;

  const TaskProviderReviewFailure(this.message);

  @override
  List<Object> get props => [
        message,
      ];
}
