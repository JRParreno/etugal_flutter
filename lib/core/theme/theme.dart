import 'package:flutter/material.dart';
import 'package:etugal_flutter/core/theme/theme_mixins.dart';
import 'package:etugal_flutter/gen/colors.gen.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme with ThemeMixin {
  static final AppTheme _instance = AppTheme();

  static final lightThemeMode = ThemeData.light().copyWith(
    scaffoldBackgroundColor: ColorName.whiteNotMuch,
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: ColorName.primary),
    appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(color: ColorName.darkerGreyFont),
      actionsIconTheme: const IconThemeData(color: ColorName.darkerGreyFont),
      backgroundColor: ColorName.whiteNotMuch,
      titleTextStyle: const AppBarTheme().titleTextStyle?.copyWith(
            color: ColorName.blackFont,
          ),
    ),
    iconTheme: const IconThemeData(
      color: ColorName.darkerGreyFont,
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.all(ColorName.darkerGreyFont),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: ColorName.whiteNotMuch,
      elevation: 1,
      selectedItemColor: ColorName.primary,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      selectedIconTheme: IconThemeData(
        color: ColorName.primary,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: ColorName.greyFont,
        letterSpacing: 1.25,
      ),
      iconColor: ColorName.greyFont,
      fillColor: Colors.white,
      filled: true,
      contentPadding: const EdgeInsets.all(15),
      enabledBorder: _instance.border(),
      border: _instance.border(),
      focusedBorder: _instance.border(),
      errorBorder: _instance.border(),
      disabledBorder: _instance.border(),
    ),
    chipTheme: ChipThemeData(
      side: const BorderSide(
        color: ColorName.greyFont,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      selectedColor: ColorName.primary,
      backgroundColor: ColorName.whiteNotMuch,
      showCheckmark: false,
      secondarySelectedColor: ColorName.whiteNotMuch,
      secondaryLabelStyle: GoogleFonts.poppins(
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: ColorName.primary,
        letterSpacing: 0.4,
      ),
      labelStyle: GoogleFonts.poppins(
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: ColorName.blackFont,
        letterSpacing: 0.4,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
        ),
        backgroundColor: ColorName.primary,
        textStyle: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: Colors.white,
          letterSpacing: 1.25,
        ),
        elevation: 0,
      ),
    ),
    textTheme: TextTheme(
      displaySmall: GoogleFonts.poppins(
        fontSize: 48.0,
        fontWeight: FontWeight.normal,
        color: Colors.black,
        letterSpacing: 0.0,
      ),
      displayMedium: GoogleFonts.poppins(
        fontSize: 60.0,
        color: Colors.black,
        fontWeight: FontWeight.normal,
        letterSpacing: -0.5,
      ),
      displayLarge: GoogleFonts.poppins(
        fontSize: 96.0,
        fontWeight: FontWeight.normal,
        color: Colors.black,
        letterSpacing: -0.5,
      ),
      labelSmall: GoogleFonts.poppins(
        fontSize: 10,
        fontWeight: FontWeight.normal,
        color: Colors.black,
        letterSpacing: 1.5,
      ),
      labelMedium: GoogleFonts.poppins(
        fontSize: 16,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
      labelLarge: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.black,
        letterSpacing: 1.25,
      ),
      bodySmall: GoogleFonts.poppins(
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: Colors.black,
        letterSpacing: 0.4,
      ),
      bodyMedium: GoogleFonts.poppins(
        fontSize: 14.0,
        color: Colors.black,
        fontWeight: FontWeight.normal,
        letterSpacing: 0.25,
      ),
      bodyLarge: GoogleFonts.poppins(
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
        color: ColorName.blackFont,
        letterSpacing: 0.5,
      ),
      titleSmall: GoogleFonts.poppins(
        fontSize: 14.0,
        color: ColorName.blackFont,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
      ),
      titleMedium: GoogleFonts.poppins(
        fontSize: 16.0,
        color: Colors.black,
        fontWeight: FontWeight.normal,
        letterSpacing: 0.15,
      ),
      titleLarge: GoogleFonts.poppins(
        fontSize: 20.0,
        color: Colors.black,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
      ),
    ),
  );
}
