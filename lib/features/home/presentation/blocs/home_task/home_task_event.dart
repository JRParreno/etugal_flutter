part of 'home_task_bloc.dart';

sealed class HomeTaskEvent extends Equatable {
  const HomeTaskEvent();

  @override
  List<Object> get props => [];
}

final class GetHomeTaskEvent extends HomeTaskEvent {
  final String search;
  final int taskCategoryId;

  const GetHomeTaskEvent({
    required this.taskCategoryId,
    required this.search,
  });

  @override
  List<Object> get props => [search];
}

final class GetHomeTaskPaginateEvent extends HomeTaskEvent {}
