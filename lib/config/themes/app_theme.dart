import 'package:e_learning_app_gp/config/themes/theme.dart';
import 'package:flutter/material.dart';
import '../../core/resources/app_colors.dart';
import 'button_theme.dart';
import 'checkbox_themedata.dart';
import 'input_decoration_theme.dart';
import 'theme_data.dart';

class AppTheme {
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.light(
        primary: MyTheme.backgroundColor1,
        secondary: MyTheme.backgroundColor2,
        tertiary: MyTheme.backgroundColor3,
      ),
      brightness: Brightness.light,
      // fontFamily: "Plus Jakarta",
      primarySwatch: AppColors.primaryMaterialColor,
      primaryColor: MyTheme.backgroundColor1,
      scaffoldBackgroundColor: MyTheme.backgroundColor,
      iconTheme: const IconThemeData(color: MyTheme.textColor),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: MyTheme.textColor),
      ),
      elevatedButtonTheme: elevatedButtonThemeData,
      textButtonTheme: textButtonThemeData,
      outlinedButtonTheme: outlinedButtonTheme(),
      inputDecorationTheme: lightInputDecorationTheme,
      checkboxTheme: checkboxThemeData.copyWith(
        side: const BorderSide(color: MyTheme.textColor),
      ),
      appBarTheme: appBarLightTheme,
      scrollbarTheme: scrollbarThemeData,
      dataTableTheme: dataTableLightThemeData,
    );
  }

  static ThemeData darkTheme(BuildContext context) {
    return ThemeData(
      colorScheme: const ColorScheme.dark(
        primary: AppColors.darkPurpleColor10,
        secondary: AppColors.darkPurpleColor30,
        tertiary: AppColors.darkPurpleColor50,
      ),
      brightness: Brightness.dark,
      // fontFamily: "Plus Jakarta",
      primaryColorDark: AppColors.darkPrimaryMaterialColor,
      primaryColor: AppColors.darkPrimaryColor,
      scaffoldBackgroundColor: AppColors.darkPurpleColor50,
      iconTheme: const IconThemeData(color: AppColors.whiteColor),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: AppColors.whiteColor),
      ),
      elevatedButtonTheme: elevatedButtonThemeData,
      textButtonTheme: textButtonThemeData,
      outlinedButtonTheme: outlinedButtonTheme(),
      inputDecorationTheme: darkInputDecorationTheme,
      checkboxTheme: checkboxThemeData.copyWith(
        side: const BorderSide(color: AppColors.blackColor40),
      ),
      appBarTheme: appBarDarkTheme,
      scrollbarTheme: scrollbarThemeData,
      dataTableTheme: dataTableDarkThemeData,
    );
  }
}
