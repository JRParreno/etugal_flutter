// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:etugal_flutter/core/common/widgets/custom_elevated_btn.dart';
import 'package:etugal_flutter/gen/colors.gen.dart';
import 'package:etugal_flutter/router/index.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:etugal_flutter/features/task/domain/entities/index.dart';
import 'package:intl/intl.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.taskEntity,
    this.onTap,
    this.performer,
  });

  final TaskEntity taskEntity;
  final VoidCallback? onTap;
  final TaskUserProfileEntity? performer;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap ??
          () {
            context.pushNamed(
              AppRoutes.taskDetail.name,
              extra: taskEntity,
            );
          },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: ColorName.darkerGreyFont),
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        padding: const EdgeInsets.all(15),
        height: 124,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    taskEntity.title,
                    style: textTheme.labelMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  iconWithText(
                    icon: Icons.location_pin,
                    title: taskEntity.address,
                    textTheme: textTheme,
                  ),
                  iconWithText(
                    icon: Icons.date_range,
                    title:
                        DateFormat.yMMMMd('en_US').format(taskEntity.createdAt),
                    textTheme: textTheme,
                  ),
                  if (performer != null) ...[
                    iconWithText(
                      icon: Icons.person,
                      title:
                          '${performer!.user.firstName} ${performer!.user.lastName}',
                      textTheme: textTheme,
                    ),
                  ] else ...[
                    iconWithText(
                      icon: Icons.schedule,
                      title: getTimeAgo(taskEntity.createdAt.toLocal()),
                      textTheme: textTheme,
                    ),
                  ]
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'PHP ${taskEntity.reward.toString()}',
                    style: textTheme.labelLarge?.copyWith(
                      color: ColorName.darkerGreyFont,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  RichText(
                    text: TextSpan(
                      text: "Type: ",
                      style: textTheme.labelSmall?.copyWith(
                        color: ColorName.darkerGreyFont,
                      ),
                      children: [
                        TextSpan(
                          text: taskEntity.workType
                              .toUpperCase()
                              .replaceAll('_', ' '),
                          style: textTheme.labelSmall?.copyWith(
                            color: ColorName.primary,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                    width: 105,
                    child: CustomElevatedBtn(
                      borderWidth: 0.5,
                      onTap: () {},
                      title: 'Details',
                      buttonType: ButtonType.outline,
                      textStyle: textTheme.labelSmall?.copyWith(
                        color: ColorName.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget iconWithText({
    required IconData icon,
    required String title,
    required TextTheme textTheme,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 17,
          color: ColorName.primary,
        ),
        const SizedBox(width: 5),
        Expanded(
          child: Text(
            title,
            style: textTheme.labelSmall?.copyWith(
              color: ColorName.darkerGreyFont,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }

  String getTimeAgo(DateTime taskDate) {
    final duration = DateTime.now().difference(taskDate);

    return timeago.format(DateTime.now().subtract(duration));
  }
}
