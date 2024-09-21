import 'package:etugal_flutter/features/task/domain/entities/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:etugal_flutter/core/common/widgets/custom_elevated_btn.dart';
import 'package:etugal_flutter/core/enums/task_status_enum.dart';
import 'package:etugal_flutter/features/task/presentation/blocs/tasks/my_task_detail/my_task_detail_bloc.dart';

class PerformerBottomBar extends StatelessWidget {
  const PerformerBottomBar({
    super.key,
    required this.onSetPerformDone,
  });

  final VoidCallback onSetPerformDone;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyTaskDetailBloc, MyTaskDetailState>(
      builder: (context, state) {
        if (state is MyTaskDetailInitial && state.taskEntity != null) {
          final task = state.taskEntity!;

          final hasReview = task.review == null ||
              (task.review != null && task.review!.performerRate > 0);

          if (getTaskStatusFromString(task.status) != TaskStatusEnum.canceled &&
              getTaskStatusFromString(task.status) != TaskStatusEnum.pending &&
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
                          TaskStatusEnum.inProgres
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
    if (getTaskStatusFromString(task.status) == TaskStatusEnum.inProgres) {
      if (task.isDonePerform) {
        return 'Waiting for Provider to complete the task.';
      }
      return 'Mark as Task done';
    }
    if (getTaskStatusFromString(task.status) == TaskStatusEnum.competed &&
        task.isDonePerform) {
      return 'Add Review';
    }

    return '';
  }

  void Function()? handleOnTapBottomNav(TaskEntity task) {
    if (getTaskStatusFromString(task.status) == TaskStatusEnum.inProgres &&
        !task.isDonePerform) {
      return () => onSetPerformDone();
    }
    if (getTaskStatusFromString(task.status) == TaskStatusEnum.competed &&
        task.isDonePerform) {
      // TODO add review action
    }

    return null;
  }
}
