import 'package:flutter/material.dart';
import 'package:etugal_flutter/gen/colors.gen.dart';

mixin ThemeMixin {
  OutlineInputBorder border([Color color = ColorName.borderColor]) =>
      OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(7),
      );
}
