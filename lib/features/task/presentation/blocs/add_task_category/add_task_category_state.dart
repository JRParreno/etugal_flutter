part of 'add_task_category_bloc.dart';

sealed class AddTaskCategoryState extends Equatable {
  const AddTaskCategoryState();

  @override
  List<Object> get props => [];
}

final class AddTaskCategoryInitial extends AddTaskCategoryState {}

final class AddTaskCategoryLoading extends AddTaskCategoryState {}

final class AddTaskCategorySuccess extends AddTaskCategoryState {
  final TaskCategoryListResponseEntity data;
  final bool isPaginate;

  const AddTaskCategorySuccess({
    required this.data,
    this.isPaginate = false,
  });

  AddTaskCategorySuccess copyWith({
    TaskCategoryListResponseEntity? data,
    bool? isPaginate,
    int? selected,
  }) {
    return AddTaskCategorySuccess(
      data: data ?? this.data,
      isPaginate: isPaginate ?? this.isPaginate,
    );
  }

  @override
  List<Object> get props => [
        data,
        isPaginate,
      ];
}

final class AddTaskCategoryFailure extends AddTaskCategoryState {
  final String message;

  const AddTaskCategoryFailure(this.message);

  @override
  List<Object> get props => [
        message,
      ];
}
