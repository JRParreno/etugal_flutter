import 'package:etugal_flutter/core/common/widgets/shimmer_loading.dart';
import 'package:etugal_flutter/core/extensions/spacer_widget.dart';
import 'package:etugal_flutter/features/task/presentation/blocs/tasks/task_provider_review/task_provider_review_bloc.dart';
import 'package:etugal_flutter/features/task/presentation/pages/body/task_provider/index.dart';
import 'package:etugal_flutter/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProviderReviewList extends StatelessWidget {
  const ProviderReviewList({super.key, required this.controller});

  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: BlocBuilder<TaskProviderReviewBloc, TaskProviderReviewState>(
        builder: (context, state) {
          if (state is TaskProviderReviewFailure) {
            return Expanded(
              child: Center(
                child: Text(state.message),
              ),
            );
          }

          if (state is TaskProviderReviewSuccess) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 20),
                  child: Text(
                    '${state.data.count ?? 0} Review(s)',
                    style: textTheme.bodySmall?.copyWith(
                      color: ColorName.darkerGreyFont,
                    ),
                  ),
                ),
                if (state.data.results.isNotEmpty) ...[
                  Expanded(
                    child: ListView.separated(
                      controller: controller,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final review = state.data.results[index];
                        return Column(
                          children: [
                            ProviderReviewCard(
                              taskReview: review,
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
                ] else ...[
                  Expanded(
                    child: Center(
                      child: Text(
                        'No Reviews yet',
                        style: textTheme.bodyMedium?.copyWith(
                          color: ColorName.darkerGreyFont,
                        ),
                      ),
                    ),
                  )
                ],
              ].withSpaceBetween(height: 10),
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