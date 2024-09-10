// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:etugal_flutter/core/extensions/spacer_widget.dart';
import 'package:etugal_flutter/features/task/domain/entities/index.dart';
import 'package:etugal_flutter/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PerformerInfo extends StatelessWidget {
  const PerformerInfo({
    super.key,
    required this.taskUserProfile,
  });

  final TaskUserProfileEntity taskUserProfile;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Performer's Info",
          style: textTheme.titleSmall,
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
          text: DateFormat.yMd().format(taskUserProfile.birthdate),
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
