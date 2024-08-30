// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:etugal_flutter/gen/colors.gen.dart';
import 'package:flutter/material.dart';

import 'package:etugal_flutter/features/task/domain/entities/index.dart';

class TaskCategoryChip extends StatelessWidget {
  const TaskCategoryChip({
    super.key,
    this.selected = false,
    required this.taskCategoryEntity,
    required this.onSelected,
  });

  final bool selected;
  final TaskCategoryEntity taskCategoryEntity;
  final Function(bool value) onSelected;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      side: BorderSide(
        color: selected ? ColorName.primary : ColorName.greyFont,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      selected: selected,
      onSelected: onSelected,
      padding: EdgeInsets.zero,
      label: Text(
        taskCategoryEntity.title,
      ),
    );
  }
}
