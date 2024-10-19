import 'package:etugal_flutter/features/task/domain/entities/index.dart';
import 'package:etugal_flutter/features/task/presentation/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import 'package:etugal_flutter/core/common/widgets/shimmer_loading.dart';
import 'package:etugal_flutter/core/enums/work_type.dart';
import 'package:etugal_flutter/features/home/presentation/widgets/task_category/task_category_chip.dart';
import 'package:etugal_flutter/features/task/presentation/blocs/add_task_category/add_task_category_bloc.dart';
import 'package:etugal_flutter/features/task/presentation/widgets/select_work_type.dart';

class FirstStepForm extends StatelessWidget {
  const FirstStepForm({
    super.key,
    required this.onSelectCategory,
    required this.onSelectWorkType,
    required this.onNext,
    this.selectedCategory,
    this.selectedWorkType,
  });

  final TaskCategoryEntity? selectedCategory;
  final Function(TaskCategoryEntity value) onSelectCategory;

  final WorkType? selectedWorkType;
  final Function(WorkType value) onSelectWorkType;

  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Select a  category that defines your task',
          style: textTheme.bodyLarge,
        ),
        BlocBuilder<AddTaskCategoryBloc, AddTaskCategoryState>(
          builder: (context, state) {
            if (state is AddTaskCategoryLoading) {
              return const Padding(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    ShimmerLoading(
                      width: double.infinity,
                      height: 50,
                    )
                  ],
                ),
              );
            }

            if (state is AddTaskCategorySuccess) {
              return Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.symmetric(
                                vertical: 35,
                              ),
                              child: Wrap(
                                alignment: WrapAlignment.start,
                                runAlignment: WrapAlignment.spaceEvenly,
                                runSpacing: 15,
                                spacing: 25,
                                children: state.data.results.mapWithIndex(
                                  (item, index) {
                                    return TaskCategoryChip(
                                      taskCategoryEntity: item,
                                      selected: selectedCategory != null &&
                                          item.title == selectedCategory!.title,
                                      onSelected: (value) =>
                                          onSelectCategory(item),
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SelectWorkType(
                              selectedWorkType: selectedWorkType,
                              onSelectWorkType: (value) {
                                onSelectWorkType(value);
                              },
                            ),
                          ],
                        ),
                      ),
                      NextButton(
                        onNext: onNext,
                        isEnabled: selectedCategory != null &&
                            selectedWorkType != null,
                      ),
                    ],
                  ),
                ),
              );
            }

            return const SizedBox();
          },
        )
      ],
    );
  }
}
