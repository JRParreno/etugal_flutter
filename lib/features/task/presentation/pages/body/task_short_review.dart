import 'package:etugal_flutter/core/extensions/spacer_widget.dart';
import 'package:etugal_flutter/gen/colors.gen.dart';
import 'package:flutter/material.dart';

import 'package:etugal_flutter/features/task/domain/entities/task_short_review_entity.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class TaskShortReview extends StatelessWidget {
  const TaskShortReview({
    super.key,
    required this.review,
  });

  final TaskShortReviewEntity review;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Review",
            style: textTheme.titleSmall,
          ),
          reviewDescription(
            title: 'Provider',
            description: review.providerFeedback,
            textTheme: textTheme,
            rate: review.providerRate,
          ),
          reviewDescription(
            title: 'Performer',
            description: review.performerFeedback,
            textTheme: textTheme,
            rate: review.performerRate,
          )
        ].withSpaceBetween(height: 10),
      ),
    );
  }

  Widget reviewDescription({
    int rate = 0,
    required String title,
    required String description,
    required TextTheme textTheme,
  }) {
    if (rate == 0) return const SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: textTheme.bodySmall
                  ?.copyWith(color: ColorName.darkerGreyFont),
            ),
            RatingStars(
              value: rate.toDouble(),
              onValueChanged: (v) {},
              starBuilder: (index, color) => Icon(
                Icons.star,
                color: color,
                size: 13,
              ),
              starCount: 5,
              starSize: 13,
              maxValue: 5,
              starSpacing: 2,
              maxValueVisibility: false,
              valueLabelVisibility: false,
              starOffColor: ColorName.darkerGreyFont,
              starColor: ColorName.primary,
            ),
          ],
        ),
        if (description.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 5),
            child: Text(
              description,
              textAlign: TextAlign.justify,
              style: textTheme.labelSmall
                  ?.copyWith(color: ColorName.darkerGreyFont),
            ),
          )
      ],
    );
  }
}
