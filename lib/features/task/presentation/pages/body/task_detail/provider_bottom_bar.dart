import 'package:etugal_flutter/features/task/domain/entities/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:etugal_flutter/core/common/widgets/custom_elevated_btn.dart';
import 'package:etugal_flutter/core/enums/task_status_enum.dart';
import 'package:etugal_flutter/features/task/presentation/blocs/tasks/my_task_detail/my_task_detail_bloc.dart';

class ProviderBottomBar extends StatelessWidget {
  const ProviderBottomBar({
    super.key,
    required this.onSetMarkAsCompleted,
    required this.onSetCancel,
    required this.onAddReview,
  });

  final VoidCallback onSetMarkAsCompleted;
  final VoidCallback onSetCancel;
  final VoidCallback onAddReview;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyTaskDetailBloc, MyTaskDetailState>(
      builder: (context, state) {
        if (state is MyTaskDetailInitial && state.taskEntity != null) {
          final task = state.taskEntity!;
          final hasReview = task.review == null ||
              (task.review != null && task.review!.providerRate == 0);
          if (getTaskStatusFromString(task.status) != TaskStatusEnum.canceled &&
              hasReview) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                boxShadow: [
                  // so here your custom shadow goes:
                  BoxShadow(
                    color: Colors.black.withAlpha(
                        20), // the color of a shadow, you can adjust it
                    spreadRadius:
                        3, //also play with this two values to achieve your ideal result
                    blurRadius: 7,
                    offset: const Offset(0,
                        -7), // changes position of shadow, negative value on y-axis makes it appering only on the top of a container
                  ),
                ],
              ),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 23,
                  vertical: 20,
                ),
                color: Colors.white,
                child: CustomElevatedBtn(
                  backgroundColor: getTaskStatusFromString(task.status) ==
                          TaskStatusEnum.pending
                      ? Colors.red
                      : null,
                  onTap: handleOnTapBottomNav(task),
                  title: onSetTitle(task),
                ),
              ),
            );
          }
        }
        return const SizedBox();
      },
    );
  }

  String onSetTitle(TaskEntity task) {
    if (task.performer == null) {
      if (getTaskStatusFromString(task.status) == TaskStatusEnum.pending) {
        return 'Cancel';
      }
    } else {
      if (getTaskStatusFromString(task.status) == TaskStatusEnum.inProgres) {
        return 'Mark as Completed';
      }
      if (getTaskStatusFromString(task.status) == TaskStatusEnum.competed) {
        return 'Add Review';
      }
    }

    return '';
  }

  void Function()? handleOnTapBottomNav(TaskEntity task) {
    if (getTaskStatusFromString(task.status) == TaskStatusEnum.pending) {
      return () => onSetCancel();
    }
    if (getTaskStatusFromString(task.status) == TaskStatusEnum.inProgres &&
        task.isDonePerform) {
      return () => onSetMarkAsCompleted();
    }

    if (getTaskStatusFromString(task.status) == TaskStatusEnum.competed &&
        task.isDonePerform) {
      return () => onAddReview();
    }

    return null;
  }
}
