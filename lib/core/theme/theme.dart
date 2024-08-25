import 'package:flutter/material.dart';
import 'package:etugal_flutter/core/theme/theme_mixins.dart';
import 'package:etugal_flutter/gen/colors.gen.dart';

class AppTheme with ThemeMixin {
  static final AppTheme _instance = AppTheme();

  static final lightThemeMode = ThemeData.light().copyWith(
    textTheme: Typography().white.apply(fontFamily: 'Signika'),
    scaffoldBackgroundColor: ColorName.primary.withOpacity(0.91),
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: ColorName.primary),
    appBarTheme: AppBarTheme(
      backgroundColor: ColorName.primary.withOpacity(0.91),
      titleTextStyle:
          const AppBarTheme().titleTextStyle?.copyWith(color: Colors.white),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: const TextStyle(
        fontFamily: 'Signika',
        fontSize: 17,
        color: Colors.white,
      ),
      fillColor: ColorName.primary,
      filled: true,
      contentPadding: const EdgeInsets.all(27),
      enabledBorder: _instance.border(),
      border: _instance.border(),
      focusedBorder: _instance.border(),
      errorBorder: _instance.border(),
    ),
    chipTheme: const ChipThemeData(
      side: BorderSide.none,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        backgroundColor: const Color(0xFF1DD0BB),
        textStyle: const TextStyle(
          fontFamily: 'Signika',
          fontSize: 25,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
        elevation: 0,
      ),
    ),
  );
}
