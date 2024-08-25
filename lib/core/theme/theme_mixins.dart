import 'package:flutter/material.dart';
import 'package:etugal_flutter/gen/colors.gen.dart';

mixin ThemeMixin {
  OutlineInputBorder border([Color color = ColorName.primary]) =>
      OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(10),
      );
}
