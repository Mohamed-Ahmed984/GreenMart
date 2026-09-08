import 'package:flutter/material.dart';
import 'package:flutter_application_13/Core/Style/app_colors.dart';

class AppThemes {
  static const String fontFamily = "Poppins";

  static const Color background = Color(0xFFF8F8F8);
  static const Color blackColor = Color(0xFF111111);
  static const Color primaryColor = Color(0xFF2DBE60);
  static const Color greyColor = Color(0xFF9E9E9E);
  static const Color accentColor = Color(0xFFEDEDED);

  static const TextStyle caption2 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  static ThemeData light = ThemeData(
    useMaterial3: true,
    fontFamily: fontFamily,
    scaffoldBackgroundColor: background,

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: blackColor),
    ),

    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      ),
    ),
    appBarTheme: AppBarTheme(backgroundColor: AppColors.background),
    colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),

    inputDecorationTheme: InputDecorationTheme(
      fillColor: accentColor,
      filled: true,
      hintStyle: caption2.copyWith(color: greyColor),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: background,
      selectedItemColor: primaryColor,
      unselectedItemColor: greyColor,
      selectedLabelStyle: caption2.copyWith(
        height: 1.8,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: caption2.copyWith(
        height: 1.8,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
