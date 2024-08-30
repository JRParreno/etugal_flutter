import 'package:etugal_flutter/gen/colors.gen.dart';
import 'package:flutter/material.dart';

Future<void> commonBottomSheetDialog({
  required BuildContext context,
  required String title,
  required Widget container,
  VoidCallback? onClose,
}) {
  final textTheme = Theme.of(context).textTheme;

  return showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.all(10),
        height: 210,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              title,
              style: textTheme.titleMedium?.copyWith(color: ColorName.primary),
            ),
            container,
          ],
        ),
      );
    },
  );
}
