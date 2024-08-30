part of 'home_task_bloc.dart';

sealed class HomeTaskEvent extends Equatable {
  const HomeTaskEvent();

  @override
  List<Object> get props => [];
}

final class GetHomeTaskEvent extends HomeTaskEvent {}

final class GetHomeTaskPaginateEvent extends HomeTaskEvent {}
