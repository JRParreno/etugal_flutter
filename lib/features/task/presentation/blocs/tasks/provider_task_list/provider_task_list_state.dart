part of 'provider_task_list_bloc.dart';

sealed class ProviderTaskListState extends Equatable {
  const ProviderTaskListState();

  @override
  List<Object> get props => [];
}

final class ProviderTaskListInitial extends ProviderTaskListState {}

final class ProviderTaskListLoading extends ProviderTaskListState {
  final int index;
  const ProviderTaskListLoading({
    this.index = -1,
  });

  @override
  List<Object> get props => [index];
}

final class ProviderTaskListSuccess extends ProviderTaskListState {
  final TaskListResponseEntity data;
  final bool isPaginate;

  const ProviderTaskListSuccess({
    required this.data,
    this.isPaginate = false,
  });

  ProviderTaskListSuccess copyWith({
    TaskListResponseEntity? data,
    bool? isPaginate,
  }) {
    return ProviderTaskListSuccess(
      data: data ?? this.data,
      isPaginate: isPaginate ?? this.isPaginate,
    );
  }

  @override
  List<Object> get props => [data, isPaginate];
}

final class ProviderTaskListFailure extends ProviderTaskListState {
  final String message;

  const ProviderTaskListFailure(this.message);

  @override
  List<Object> get props => [
        message,
      ];
}
