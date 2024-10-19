import 'package:etugal_flutter/core/extensions/spacer_widget.dart';
import 'package:etugal_flutter/gen/colors.gen.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProviderProfile extends StatelessWidget {
  const ProviderProfile({
    super.key,
    required this.address,
    required this.title,
    required this.createdAt,
    this.profilePhoto,
  });

  final String title;
  final String address;
  final DateTime createdAt;
  final String? profilePhoto;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Text(
          title,
          style: textTheme.titleLarge,
        ),
        const SizedBox(height: 29),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundColor: ColorName.primary,
              backgroundImage: profilePhoto != null
                  ? Image.network(profilePhoto!).image
                  : null,
              radius: 55,
              child: profilePhoto == null
                  ? const Icon(
                      Icons.person_outline,
                      size: 55 * 0.75,
                      color: ColorName.whiteNotMuch,
                    )
                  : null,
            ),
            const SizedBox(width: 30),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textWithIcon(
                    iconData: Icons.location_on_outlined,
                    title: address,
                    textTheme: textTheme,
                  ),
                  textWithIcon(
                    iconData: Icons.calendar_month_outlined,
                    title: DateFormat.yMMMMd('en_US').format(createdAt),
                    textTheme: textTheme,
                  ),
                  textWithIcon(
                    iconData: Icons.schedule_outlined,
                    title: getTimeAgo(createdAt),
                    textTheme: textTheme,
                  ),
                ].withSpaceBetween(height: 9),
              ),
            )
          ],
        )
      ],
    );
  }

  Widget textWithIcon({
    required IconData iconData,
    required String title,
    required TextTheme textTheme,
  }) {
    return Row(
      children: [
        Icon(
          iconData,
          size: 20,
          color: ColorName.primary,
        ),
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
      ].withSpaceBetween(width: 11),
    );
  }

  String getTimeAgo(DateTime taskDate) {
    final duration = DateTime.now().difference(taskDate);

    return timeago.format(DateTime.now().subtract(duration));
  }
}
