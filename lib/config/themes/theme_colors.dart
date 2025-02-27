import 'package:ElevatED/core/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:themed/themed.dart';

class MyTheme {
  // NEW THEME

  static const tempPrimary = ColorRef(Color(0xFFF4A900));
  static const tempBackgroundColor = ColorRef(Color(0xFFF8E8C0));

  //* Background Colors
  static const backgroundColor =
      ColorRef(Color(0xFFFFFFFF), id: "backgroundColor");
  static const backgroundGradientColor = ColorRef(Color(0xF59AC8FF));

  //* Common Colors
  static const brighterPrimaryColor =
      ColorRef(Color(0xFF429EF9), id: "brighterPrimaryColor");
  static const primaryColor = ColorRef(Color(0xFF2889FB), id: "primaryColor");
  static const darkerPrimaryColor =
      ColorRef(Color(0xFF206FCC), id: "darkerPrimaryColor");
  static const secondaryColor =
      ColorRef(Color(0xFFD0E5FE), id: "secondaryColor");
  static const onSecondaryColor =
      ColorRef(Color(0xFF2889FB), id: "onSecondaryColor");
  static const surfaceColor = ColorRef(Color(0xFFD0E5FE), id: "surfaceColor");
  static const onSurfaceColor =
      ColorRef(Color(0xFFFFFFFF), id: "onSurfaceColor");

  //* Text Colors
  static const textColor = ColorRef(Color(0xFF1A1A1A), id: "textColor");
  static const inverseTextColor =
      ColorRef(Color(0xFFFFFFFF), id: "inverseTextColor");
  static final labelTextColor =
      ColorRef(Colors.grey[500], id: "labelTextColor");
  static final hintTextColor = ColorRef(Colors.grey[500], id: "hintTextColor");

  //* Stats Char Colors
  static const charBackground =
      ColorRef(Color(0xFFEDF2FA), id: "charBackground");
  static const charNotchColor =
      ColorRef(Color(0xFF2889FB), id: "charNotchColor");
  static const charTopColor = ColorRef(Color(0xFF2889FB), id: "charTopColor");
  static const charBottomColor =
      ColorRef(Color(0xFF2889FB), id: "charBottomColor");
}

Map<ThemeRef, Object> darkTheme = {
  MyTheme.tempBackgroundColor: const Color(0xFF1A1A1A),
  MyTheme.surfaceColor: const Color(0xFF0C172B),
  MyTheme.onSurfaceColor: const Color(0xFF1F2833),
  MyTheme.secondaryColor: const Color(0xFF1F2833),
  MyTheme.onSecondaryColor: const Color(0xFFFFFFFF),
  MyTheme.backgroundColor: const Color(0xFF010A1B),
  MyTheme.textColor: const Color(0xFFFFFFFF),
  MyTheme.inverseTextColor: const Color(0xFF1A1A1A),
  MyTheme.backgroundGradientColor: const Color(0xF51F2833)
};

// NEW THEME
class ThemeColors {
  static const backgroundColor =
      ColorRef(AppColors.lightBackgroundColor, id: "background");

  static const secondaryColor =
      ColorRef(AppColors.lightSecondaryColor, id: "secondary");

  static const textColor = ColorRef(AppColors.darkBackgroundColor, id: "text");

  static const subTextColor = ColorRef(AppColors.surfaceColor, id: "subText");

  static const inverseTextColor =
      ColorRef(AppColors.whiteColor, id: "inverseText");

  static const disabledColor =
      ColorRef(AppColors.lightHintColor, id: "disabled");

  static const lightSurfaceToDarkSecondary =
      ColorRef(AppColors.surfaceColor, id: "lightSurfaceToDarkSecondary");
}

Map<ThemeRef, Object> lightTheme = {};

Map<ThemeRef, Object> newDarkTheme = {
  ThemeColors.backgroundColor: AppColors.darkBackgroundColor,
  ThemeColors.secondaryColor: AppColors.darkSecondaryColor,
  ThemeColors.textColor: AppColors.whiteColor,
  ThemeColors.subTextColor: AppColors.darkSubColor,
  ThemeColors.inverseTextColor: AppColors.darkBackgroundColor,
  ThemeColors.disabledColor: AppColors.surfaceColor,
  ThemeColors.lightSurfaceToDarkSecondary: AppColors.darkSecondaryColor,
};
