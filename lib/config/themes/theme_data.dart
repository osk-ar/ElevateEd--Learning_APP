import 'package:ElevatED/config/themes/input_decoration_theme.dart';
import 'package:ElevatED/core/resources/app_colors.dart';
import 'package:flutter/material.dart';

ThemeData lightThemeData = ThemeData.light().copyWith(
  //-
  textSelectionTheme: textSelectionThemeData,
  inputDecorationTheme: lightInputDecorationTheme,
  //-
  colorScheme: const ColorScheme.light(
      primary: AppColors.primaryColor,
      onPrimary: Colors.white,
      //-
      surface: AppColors.primaryColor,
      onSurface: AppColors.darkBackgroundColor,
      error: AppColors.lightErrorColor),
);

ThemeData darkThemeData = ThemeData.dark().copyWith(
  //-
  textSelectionTheme: textSelectionThemeData,
  inputDecorationTheme: darkInputDecorationTheme,
  //-
  colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryColor,
      onPrimary: Colors.white,
      //-
      surface: AppColors.onSurfaceColor,
      onSurface: AppColors.whiteColor,
      error: AppColors.lightErrorColor),
);

TextSelectionThemeData textSelectionThemeData = TextSelectionThemeData(
  selectionColor: AppColors.primaryColor.withOpacity(0.4),
  selectionHandleColor: AppColors.primaryColor,
  cursorColor: AppColors.primaryColor,
);
