// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:etugal_flutter/core/extensions/spacer_widget.dart';
import 'package:etugal_flutter/features/task/domain/entities/index.dart';
import 'package:etugal_flutter/gen/colors.gen.dart';
import 'package:etugal_flutter/router/index.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class PerformerInfo extends StatelessWidget {
  const PerformerInfo({
    super.key,
    required this.taskUserProfile,
    this.isHideHeader = false,
    this.isHideViewProfile = false,
  });

  final TaskUserProfileEntity taskUserProfile;
  final bool isHideHeader;
  final bool isHideViewProfile;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isHideHeader)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Performer's Info",
                style: textTheme.titleSmall,
              ),
              if (!isHideViewProfile)
                GestureDetector(
                  onTap: () {
                    context.pushNamed(
                      AppRoutes.taskApplicantDetail.name,
                      extra: taskUserProfile,
                    );
                  },
                  child: Text(
                    'View Profile',
                    style: textTheme.titleSmall
                        ?.copyWith(color: ColorName.primary),
                  ),
                ),
            ].withSpaceBetween(height: 11),
          ),
        rowInfoText(
            info: "Full name",
            text:
                '${taskUserProfile.user.firstName} ${taskUserProfile.user.lastName}',
            textTheme: textTheme),
        rowInfoText(
          info: "Gender",
          text: taskUserProfile.gender == 'M' ? 'Male' : 'Female',
          textTheme: textTheme,
        ),
        rowInfoText(
          info: "Birthdate",
          text: DateFormat.yMMMMd('en_US').format(taskUserProfile.birthdate),
          textTheme: textTheme,
        ),
        rowInfoText(
          info: "Address",
          text: taskUserProfile.address,
          textTheme: textTheme,
        ),
        rowInfoText(
          info: "Contact Number",
          text: taskUserProfile.contactNumber,
          textTheme: textTheme,
        ),
      ].withSpaceBetween(height: 11),
    );
  }

  Widget rowInfoText({
    required String info,
    required String text,
    required TextTheme textTheme,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          info,
          style: textTheme.bodySmall?.copyWith(color: ColorName.darkerGreyFont),
        ),
        Text(
          text,
          style: textTheme.bodySmall,
        ),
      ],
    );
  }
}
