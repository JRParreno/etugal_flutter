import 'package:etugal_flutter/features/task/domain/entities/index.dart';
import 'package:etugal_flutter/features/task/presentation/widgets/index.dart';
import 'package:etugal_flutter/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import 'package:etugal_flutter/core/common/widgets/shimmer_loading.dart';
import 'package:etugal_flutter/core/enums/work_type.dart';
import 'package:etugal_flutter/features/home/presentation/widgets/task_category/task_category_chip.dart';
import 'package:etugal_flutter/features/task/presentation/blocs/add_task_category/add_task_category_bloc.dart';
import 'package:etugal_flutter/features/task/presentation/widgets/select_work_type.dart';
import 'package:input_quantity/input_quantity.dart';

class FirstStepForm extends StatelessWidget {
  const FirstStepForm({
    super.key,
    required this.onSelectCategory,
    required this.onSelectWorkType,
    required this.onNext,
    this.selectedCategory,
    this.selectedWorkType,
    this.numWorker,
    required this.onChangeQuantity,
  });

  final TaskCategoryEntity? selectedCategory;
  final Function(TaskCategoryEntity value) onSelectCategory;

  final WorkType? selectedWorkType;
  final Function(WorkType value) onSelectWorkType;

  final VoidCallback onNext;

  final int? numWorker;
  final Function(int value) onChangeQuantity;

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
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                            selected:
                                                selectedCategory != null &&
                                                    item.title ==
                                                        selectedCategory!.title,
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
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    'Number of worker',
                                    style: textTheme.labelMedium,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Specify how many person/s needed for this task?',
                                    style: textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.w200,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30),
                                    child: InputQty.int(
                                      decoration: QtyDecorationProps(
                                          minusBtn: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.remove_circle,
                                              color: Colors.red,
                                            ),
                                          ),
                                          plusBtn: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.add_circle,
                                              color: ColorName.primary,
                                            ),
                                          ),
                                          width: (MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.5)
                                              .toInt()),
                                      qtyFormProps: const QtyFormProps(
                                        keyboardType: TextInputType.number,
                                      ),
                                      maxVal: 100,
                                      initVal: numWorker ?? 0,
                                      minVal: 1,
                                      steps: 1,
                                      onQtyChanged: (val) {
                                        onChangeQuantity(val);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    NextButton(
                      onNext: onNext,
                      isEnabled:
                          selectedCategory != null && selectedWorkType != null,
                    ),
                  ],
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
