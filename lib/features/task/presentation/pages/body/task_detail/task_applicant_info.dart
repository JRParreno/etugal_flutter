import 'package:etugal_flutter/gen/colors.gen.dart';
import 'package:flutter/material.dart';

import 'package:etugal_flutter/features/task/domain/entities/index.dart';

class TaskApplicantInfo extends StatelessWidget {
  const TaskApplicantInfo({
    super.key,
    required this.performer,
    required this.onTapAccept,
    required this.onViewPerformer,
  });

  final TaskUserProfileEntity performer;
  final VoidCallback onTapAccept;
  final VoidCallback onViewPerformer;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onViewPerformer,
            child: Text(
              '${performer.user.firstName} ${performer.user.lastName} ',
              style: textTheme.bodyMedium?.copyWith(
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          GestureDetector(
            onTap: onTapAccept,
            child: Container(
              decoration: BoxDecoration(
                color: ColorName.primary,
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              child: Text(
                'Accept',
                style: textTheme.bodySmall?.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
