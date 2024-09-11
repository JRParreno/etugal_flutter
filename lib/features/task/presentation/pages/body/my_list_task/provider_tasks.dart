import 'package:etugal_flutter/core/common/widgets/shimmer_loading.dart';
import 'package:etugal_flutter/features/home/presentation/widgets/task/index.dart';
import 'package:etugal_flutter/features/task/presentation/blocs/tasks/provider_task_list/provider_task_list_bloc.dart';
import 'package:etugal_flutter/gen/assets.gen.dart';
import 'package:etugal_flutter/gen/colors.gen.dart';
import 'package:etugal_flutter/router/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProviderTasks extends StatelessWidget {
  const ProviderTasks({
    super.key,
    required this.controller,
    required this.scrollController,
    required this.onTapTab,
  });

  final TabController controller;
  final ScrollController scrollController;
  final Function(int index) onTapTab;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 15),
          decoration: BoxDecoration(
            border: Border.all(color: ColorName.primary),
            borderRadius: BorderRadius.circular(5),
          ),
          child: TabBar(
            onTap: onTapTab,
            controller: controller,
            automaticIndicatorColorAdjustment: true,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            indicator: BoxDecoration(
              color: ColorName.primary,
              borderRadius: BorderRadius.circular(5),
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: textTheme.labelSmall?.copyWith(color: Colors.white),
            unselectedLabelColor: ColorName.primary,
            indicatorColor: ColorName.primary,
            dividerHeight: 0,
            tabs: const [
              Tab(
                child: Text(
                  'Pending',
                ),
              ),
              Tab(
                child: Text(
                  'In Progress',
                ),
              ),
              Tab(
                child: Text(
                  'Completed',
                ),
              ),
              Tab(
                child: Text(
                  'Cancelled',
                ),
              ),
              Tab(
                child: Text(
                  'Rejected',
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: BlocConsumer<ProviderTaskListBloc, ProviderTaskListState>(
            listener: (context, state) {
              if (state is ProviderTaskListLoading) {
                if (state.index > -1) {
                  controller.animateTo(state.index);
                }
              }
            },
            builder: (context, state) {
              if (state is ProviderTaskListFailure) {
                return Center(
                  child: Text(state.message),
                );
              }

              if (state is ProviderTaskListSuccess) {
                if (state.data.results.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Assets.images.task.noTaskYet.image(),
                        const SizedBox(height: 10),
                        Text(
                          'No task yet',
                          style: textTheme.bodyMedium?.copyWith(
                            color: ColorName.darkerGreyFont,
                          ),
                        )
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () {
                    onTapTab(controller.index);
                    return Future<void>.value();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ListView.separated(
                      controller: scrollController,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final item = state.data.results[index];

                        return Column(
                          children: [
                            TaskCard(
                              taskEntity: item,
                              onTap: () {
                                context.pushNamed(
                                  AppRoutes.myTaskDetail.name,
                                  extra: item,
                                );
                              },
                              performer: item.performer,
                            ),
                            if (index == (state.data.results.length - 1) &&
                                state.isPaginate)
                              const SizedBox(
                                height: 15,
                                child: ShimmerLoading(
                                  width: double.infinity,
                                  height: 124,
                                ),
                              ),
                          ],
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 15,
                      ),
                      itemCount: state.data.results.length,
                    ),
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
                itemCount: 4,
              );
            },
          ),
        ),
      ],
    );
  }
}
