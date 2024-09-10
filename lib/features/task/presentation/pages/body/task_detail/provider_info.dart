// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:etugal_flutter/core/extensions/spacer_widget.dart';
import 'package:etugal_flutter/gen/colors.gen.dart';
import 'package:flutter/material.dart';

class ProviderInfo extends StatelessWidget {
  const ProviderInfo({
    super.key,
    required this.fullName,
    required this.gender,
  });

  final String fullName;
  final String gender;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Provider's Info",
          style: textTheme.titleSmall,
        ),
        rowInfoText(info: "Full name", text: fullName, textTheme: textTheme),
        rowInfoText(
          info: "Gender",
          text: gender == 'M' ? 'Male' : 'Female',
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
