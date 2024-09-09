part of 'add_task_category_bloc.dart';

sealed class AddTaskCategoryEvent extends Equatable {
  const AddTaskCategoryEvent();

  @override
  List<Object> get props => [];
}

final class GetAddTaskCategoryEvent extends AddTaskCategoryEvent {}

final class GetTaskCategoryPaginateEvent extends AddTaskCategoryEvent {}

final class OnTapAddTaskCategoryEvent extends AddTaskCategoryEvent {
  final int index;

  const OnTapAddTaskCategoryEvent(this.index);

  @override
  List<Object> get props => [index];
}
