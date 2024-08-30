part of 'home_task_category_bloc.dart';

sealed class HomeTaskCategoryState extends Equatable {
  const HomeTaskCategoryState();

  @override
  List<Object> get props => [];
}

final class HomeTaskCategoryInitial extends HomeTaskCategoryState {}

final class HomeTaskCategoryLoading extends HomeTaskCategoryState {}

final class HomeTaskCategorySuccess extends HomeTaskCategoryState {
  final TaskCategoryListResponseEntity data;
  final bool isPaginate;
  final int selected;

  const HomeTaskCategorySuccess({
    required this.data,
    this.isPaginate = false,
    this.selected = 0,
  });

  HomeTaskCategorySuccess copyWith({
    TaskCategoryListResponseEntity? data,
    bool? isPaginate,
    int? selected,
  }) {
    return HomeTaskCategorySuccess(
      data: data ?? this.data,
      isPaginate: isPaginate ?? this.isPaginate,
      selected: selected ?? this.selected,
    );
  }

  @override
  List<Object> get props => [
        data,
        isPaginate,
        selected,
      ];
}

final class HomeTaskCategoryFailure extends HomeTaskCategoryState {
  final String message;

  const HomeTaskCategoryFailure(this.message);

  @override
  List<Object> get props => [
        message,
      ];
}
