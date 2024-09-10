// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:etugal_flutter/features/home/presentation/blocs/home_task_category/home_task_category_bloc.dart';
import 'package:etugal_flutter/features/home/presentation/widgets/task/task_card.dart';
import 'package:etugal_flutter/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:etugal_flutter/core/common/widgets/shimmer_loading.dart';
import 'package:etugal_flutter/features/home/presentation/blocs/home_task/home_task_bloc.dart';

class TaskList extends StatelessWidget {
  const TaskList({
    super.key,
    required this.controller,
  });

  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Expanded(
      child: BlocBuilder<HomeTaskBloc, HomeTaskState>(
        builder: (context, state) {
          if (state is HomeTaskFailure) {
            return Center(
              child: Text(state.message),
            );
          }

          if (state is HomeTaskSuccess) {
            if (state.data.results.isEmpty) {
              return Center(
                child: Text(
                  'No result, try different keyword.',
                  style: textTheme.bodyMedium?.copyWith(
                    color: ColorName.darkerGreyFont,
                  ),
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () {
                context.read<HomeTaskBloc>().add(RefreshHomeTaskEvent());
                context
                    .read<HomeTaskCategoryBloc>()
                    .add(GetHomeTaskCategoryEvent());
                return Future<void>.value();
              },
              child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final item = state.data.results[index];

                  return TaskCard(taskEntity: item);
                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: 15,
                ),
                itemCount: state.data.results.length,
              ),
            );
          }

          return ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return const ShimmerLoading(
                width: double.infinity,
                height: 124,
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
              height: 15,
            ),
            itemCount: 3,
          );
        },
      ),
    );
  }
}
