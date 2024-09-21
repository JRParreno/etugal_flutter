import 'package:etugal_flutter/core/common/widgets/custom_elevated_btn.dart';
import 'package:etugal_flutter/core/extensions/spacer_widget.dart';
import 'package:etugal_flutter/features/task/domain/entities/task_entity.dart';
import 'package:etugal_flutter/features/task/presentation/blocs/cubit/review_star_cubit.dart';
import 'package:etugal_flutter/features/task/presentation/blocs/tasks/my_task_detail/my_task_detail_bloc.dart';
import 'package:etugal_flutter/features/task/presentation/widgets/index.dart';
import 'package:etugal_flutter/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:go_router/go_router.dart';

Future<void> addFeedbackBottomSheetDialog({
  required BuildContext context,
  required TaskEntity task,
  required TextEditingController controller,
  bool isProvider = false,
  VoidCallback? onClose,
}) {
  return showModalBottomSheet<String>(
    context: context,
    isDismissible: true,
    useSafeArea: true,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return BlocBuilder<ReviewStarCubit, double>(
        builder: (context, state) {
          return FractionallySizedBox(
            heightFactor: 0.8,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Text(
                    'Feedback for ${isProvider ? 'Performer' : 'Provider'}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 15),
                  CustomTextFormField(
                    keyboardType: TextInputType.multiline,
                    hintText: 'Write your feedback',
                    controller: controller,
                    minLines: 6,
                    maxLines: 20,
                    maxLength: 500,
                  ),
                  const SizedBox(height: 25),
                  Center(
                    child: RatingStars(
                      value: state,
                      onValueChanged: (v) {
                        context.read<ReviewStarCubit>().onChangeStars(v);
                      },
                      starBuilder: (index, color) => Icon(
                        Icons.star,
                        color: color,
                        size: 50,
                      ),
                      starCount: 5,
                      starSize: 50,
                      maxValue: 5,
                      starSpacing: 10,
                      maxValueVisibility: false,
                      valueLabelVisibility: false,
                      starOffColor: ColorName.darkerGreyFont,
                      starColor: ColorName.primary,
                    ),
                  ),
                  const SizedBox(height: 25),
                  CustomElevatedBtn(
                    onTap: state > 0 ? () => context.pop('submit') : null,
                    title: 'Submit Feedback',
                  ),
                ].withSpaceBetween(height: 15),
              ),
            ),
          );
        },
      );
    },
  ).then(
    (value) {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (value == 'submit') {
          final rate = context.read<ReviewStarCubit>().state;
          context.read<MyTaskDetailBloc>().add(
                AddFeedbackTaskDetailEvent(
                  isProvider: isProvider,
                  feedback: controller.value.text,
                  rate: rate.toInt(),
                ),
              );
          return;
        }
      });
    },
  );
}
