import 'package:etugal_flutter/core/extensions/spacer_widget.dart';
import 'package:etugal_flutter/features/task/domain/entities/index.dart';
import 'package:etugal_flutter/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:intl/intl.dart';

class PerformerReviewCard extends StatelessWidget {
  const PerformerReviewCard({super.key, required this.taskReview});

  final TaskReviewEntity taskReview;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final profile = taskReview.task.provider;

    return Container(
      padding: const EdgeInsets.all(21),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: ColorName.borderColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: ColorName.primary,
            backgroundImage: profile.profilePhoto != null
                ? Image.network(profile.profilePhoto!).image
                : null,
            radius: 30,
            child: profile.profilePhoto == null
                ? const Icon(
                    Icons.person_outline,
                    size: 30 * 0.75,
                    color: ColorName.whiteNotMuch,
                  )
                : null,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(profile.user.getFullName!, style: textTheme.bodySmall),
                    Text(
                        DateFormat.yMMMMd('en_US').format(taskReview.createdAt),
                        style: textTheme.labelSmall
                            ?.copyWith(color: ColorName.darkerGreyFont))
                  ],
                ),
                RatingStars(
                  value: taskReview.providerRate.toDouble(),
                  onValueChanged: (v) {},
                  starBuilder: (index, color) => Icon(
                    Icons.star,
                    color: color,
                  ),
                  starCount: 5,
                  starSize: 20,
                  maxValue: 5,
                  starSpacing: 2,
                  maxValueVisibility: false,
                  valueLabelVisibility: false,
                  starOffColor: ColorName.darkerGreyFont,
                  starColor: ColorName.primary,
                ),
                if (taskReview.providerFeedback.isNotEmpty)
                  Text(
                    taskReview.providerFeedback,
                    textAlign: TextAlign.justify,
                    style: textTheme.labelSmall
                        ?.copyWith(color: ColorName.darkerGreyFont),
                  )
              ].withSpaceBetween(height: 10),
            ),
          ),
        ].withSpaceBetween(width: 10),
      ),
    );
  }
}
