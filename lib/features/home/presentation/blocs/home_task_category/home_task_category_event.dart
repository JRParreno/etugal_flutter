part of 'home_task_category_bloc.dart';

sealed class HomeTaskCategoryEvent extends Equatable {
  const HomeTaskCategoryEvent();

  @override
  List<Object> get props => [];
}

final class GetHomeTaskCategoryEvent extends HomeTaskCategoryEvent {}

final class GetHomeTaskCategoryPaginateEvent extends HomeTaskCategoryEvent {}

final class OnTapHomeTaskCategoryEvent extends HomeTaskCategoryEvent {
  final int index;

  const OnTapHomeTaskCategoryEvent(this.index);

  @override
  List<Object> get props => [index];
}
