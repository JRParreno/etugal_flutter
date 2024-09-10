// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:etugal_flutter/core/extensions/datetime_ext.dart';
import 'package:etugal_flutter/core/extensions/spacer_widget.dart';
import 'package:etugal_flutter/features/task/presentation/widgets/index.dart';
import 'package:etugal_flutter/gen/colors.gen.dart';

class ThirdStepForm extends StatelessWidget {
  const ThirdStepForm({
    super.key,
    required this.dateSelected,
    required this.onNext,
    required this.onSetDate,
    this.timeSelected,
    required this.onSetTime,
  });

  final DateTime dateSelected;
  final TimeOfDay? timeSelected;
  final VoidCallback onNext;
  final Function(Future<DateTime?> value) onSetDate;
  final Function(Future<TimeOfDay?> value) onSetTime;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Choose a date',
                      style: textTheme.bodyLarge,
                    ),
                    Text(
                      'When do you need this to be done?',
                      style: textTheme.bodySmall
                          ?.copyWith(fontWeight: FontWeight.w300),
                    ),
                    dateTimeButton(
                      icon: const Icon(
                        Icons.date_range,
                        color: Colors.white,
                      ),
                      onTap: () {
                        onSetDate(handleSetDate(context));
                      },
                      title: dateSelected.isSameDate(DateTime.now())
                          ? 'Today, ${DateFormat('MMM d').format(dateSelected)}'
                          : DateFormat.yMMMMd('en_US').format(dateSelected),
                      isEnable: true,
                      textTheme: textTheme,
                    ),
                  ].withSpaceBetween(height: 10),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Choose a time',
                      style: textTheme.bodyLarge,
                    ),
                    Text(
                      'What time in the day would you like this to be done? (Not require)',
                      style: textTheme.bodySmall
                          ?.copyWith(fontWeight: FontWeight.w300),
                    ),
                    dateTimeButton(
                      icon: const Icon(
                        Icons.schedule,
                        color: Colors.white,
                      ),
                      onTap: () {
                        onSetTime(handleSetTime(context));
                      },
                      isEnable: timeSelected != null,
                      title: timeSelected != null
                          ? formatTimeOfDay(timeSelected!)
                          : 'No preference',
                      textTheme: textTheme,
                    ),
                  ].withSpaceBetween(height: 10),
                ),
              ].withSpaceBetween(height: 30),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        NextButton(
          onNext: onNext,
          isEnabled: true,
        ),
      ],
    );
  }

  Widget dateTimeButton({
    bool isEnable = false,
    required String title,
    required VoidCallback onTap,
    required Widget icon,
    required TextTheme textTheme,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 55,
        width: double.infinity,
        decoration: BoxDecoration(
          color: !isEnable ? const Color(0xFFE9E9E9) : ColorName.primary,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            Expanded(
              child: Center(
                child: Padding(
                  padding: isEnable
                      ? const EdgeInsets.only(left: 25)
                      : EdgeInsets.zero,
                  child: Text(
                    title,
                    style: textTheme.bodyLarge?.copyWith(
                        color: !isEnable ? ColorName.blackFont : Colors.white),
                  ),
                ),
              ),
            ),
            if (isEnable)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: icon,
              ),
          ],
        ),
      ),
    );
  }

  Future<DateTime?> handleSetDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(3000, 1, 1),
      currentDate: DateTime.now(),
    );

    return date;
  }

  Future<TimeOfDay?> handleSetTime(BuildContext context) async {
    final time = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 9, minute: 0),
    );

    return time;
  }

  String formatTimeOfDay(TimeOfDay tod) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm(); //"6:00 AM"
    return format.format(dt);
  }
}
