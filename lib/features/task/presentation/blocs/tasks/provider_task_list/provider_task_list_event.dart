part of 'provider_task_list_bloc.dart';

sealed class ProviderTaskListEvent extends Equatable {
  const ProviderTaskListEvent();

  @override
  List<Object> get props => [];
}

final class GetProviderTaskListTaskEvent extends ProviderTaskListEvent {
  final TaskStatusEnum taskStatus;
  final int index;

  const GetProviderTaskListTaskEvent({
    required this.taskStatus,
    this.index = -1,
  });

  @override
  List<Object> get props => [
        taskStatus,
        index,
      ];
}

final class RefreshProviderTaskListTaskEvent extends ProviderTaskListEvent {}

final class GetProviderTaskListTaskPaginateEvent
    extends ProviderTaskListEvent {}
