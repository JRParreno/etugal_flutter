// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:etugal_flutter/core/extensions/spacer_widget.dart';
import 'package:etugal_flutter/gen/colors.gen.dart';
import 'package:flutter/material.dart';

import 'package:etugal_flutter/core/enums/work_type.dart';

class SelectWorkType extends StatelessWidget {
  const SelectWorkType({
    super.key,
    this.selectedWorkType,
    required this.onSelectWorkType,
  });

  final WorkType? selectedWorkType;
  final Function(WorkType value) onSelectWorkType;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Task Type',
          style: textTheme.labelMedium,
        ),
        Text(
          'How do you like your task to be performed?',
          style: textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w200,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            onSelectRadio(
              textTheme: textTheme,
              title: 'In-person',
              workType: WorkType.inPerson,
            ),
            onSelectRadio(
              textTheme: textTheme,
              title: 'Online',
              workType: WorkType.online,
            ),
          ].withSpaceBetween(width: 20),
        )
      ].withSpaceBetween(height: 10),
    );
  }

  Widget onSelectRadio({
    required String title,
    required WorkType workType,
    required TextTheme textTheme,
  }) {
    return Row(
      children: [
        Radio(
          value: workType,
          groupValue: selectedWorkType,
          onChanged: (value) {
            if (value != null) {
              onSelectWorkType(value);
            }
          },
          activeColor: ColorName.primary,
        ),
        Text(
          title,
          style: textTheme.bodyMedium,
        ),
      ],
    );
  }
}
