// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:etugal_flutter/gen/colors.gen.dart';
import 'package:flutter/material.dart';

enum ButtonType { normal, outline }

class CustomElevatedBtn extends StatelessWidget {
  const CustomElevatedBtn({
    super.key,
    required this.onTap,
    required this.title,
    this.buttonType = ButtonType.normal,
  });

  final VoidCallback onTap;
  final String title;
  final ButtonType buttonType;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    switch (buttonType) {
      case ButtonType.outline:
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
              side: const BorderSide(
                color: ColorName.primary,
              ),
            ),
          ),
          onPressed: onTap,
          child: Text(
            title,
            style: textTheme.bodyMedium?.copyWith(
              color: ColorName.primary,
            ),
          ),
        );
      default:
        return ElevatedButton(
          onPressed: onTap,
          child: Text(
            title,
            style: textTheme.bodyMedium?.copyWith(
              color: Colors.white,
            ),
          ),
        );
    }
  }
}
