// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:etugal_flutter/core/common/widgets/shimmer_loading.dart';
import 'package:etugal_flutter/features/home/presentation/blocs/home_task/home_task_bloc.dart';
import 'package:etugal_flutter/features/home/presentation/blocs/home_task_category/home_task_category_bloc.dart';
import 'package:etugal_flutter/features/home/presentation/widgets/task_category/task_category_chip.dart';

class TaskCategoryList extends StatelessWidget {
  const TaskCategoryList({
    super.key,
    required this.searchCtrl,
  });

  final TextEditingController searchCtrl;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeTaskCategoryBloc, HomeTaskCategoryState>(
      listener: (context, state) {
        if (state is HomeTaskCategorySuccess) {
          context.read<HomeTaskBloc>().add(
                GetHomeTaskEvent(
                  search: searchCtrl.value.text,
                  taskCategoryId: state.data.results[state.selected].id,
                ),
              );
        }
      },
      builder: (context, state) {
        if (state is HomeTaskCategoryLoading) {
          return const ShimmerLoading(
            width: double.infinity,
            height: 50,
          );
        }

        if (state is HomeTaskCategorySuccess) {
          return SizedBox(
            height: 40,
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final item = state.data.results[index];
                return TaskCategoryChip(
                  taskCategoryEntity: item,
                  selected: index == state.selected,
                  onSelected: (value) =>
                      handleOnTapCategory(context: context, index: index),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                width: 8,
              ),
              itemCount: state.data.results.length,
            ),
          );
        }

        return const SizedBox();
      },
    );
  }

  void handleOnTapCategory({
    required int index,
    required BuildContext context,
  }) {
    context.read<HomeTaskCategoryBloc>().add(OnTapHomeTaskCategoryEvent(index));
  }
}
