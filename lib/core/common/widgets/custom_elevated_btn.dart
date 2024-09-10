// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:etugal_flutter/gen/colors.gen.dart';
import 'package:flutter/material.dart';

enum ButtonType { normal, outline }

class CustomElevatedBtn extends StatelessWidget {
  const CustomElevatedBtn({
    super.key,
    required this.title,
    this.buttonType = ButtonType.normal,
    this.borderWidth = 1,
    this.textStyle,
    this.onTap,
    this.backgroundColor,
  });

  final VoidCallback? onTap;
  final String title;
  final ButtonType buttonType;
  final double borderWidth;
  final TextStyle? textStyle;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    switch (buttonType) {
      case ButtonType.outline:
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
              side: BorderSide(
                color: backgroundColor ?? ColorName.primary,
                width: borderWidth,
              ),
            ),
          ),
          onPressed: onTap,
          child: Text(
            title,
            style: textStyle ??
                textTheme.bodyMedium?.copyWith(
                  color: ColorName.primary,
                ),
          ),
        );
      default:
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? ColorName.primary,
          ),
          onPressed: onTap,
          child: Text(
            title,
            style: textStyle ??
                textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                ),
          ),
        );
    }
  }
}
