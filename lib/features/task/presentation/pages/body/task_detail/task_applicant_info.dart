import 'package:etugal_flutter/gen/colors.gen.dart';
import 'package:flutter/material.dart';

import 'package:etugal_flutter/features/task/domain/entities/index.dart';

class TaskApplicantInfo extends StatelessWidget {
  const TaskApplicantInfo({
    super.key,
    required this.performer,
    required this.onViewPerformer,
  });

  final TaskUserProfileEntity performer;
  final VoidCallback onViewPerformer;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onViewPerformer,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${performer.user.firstName} ${performer.user.lastName} ',
              style: textTheme.bodyMedium,
            ),
            Container(
              decoration: BoxDecoration(
                color: ColorName.primary,
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              child: Text(
                'View Applicant',
                style: textTheme.bodySmall?.copyWith(
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
