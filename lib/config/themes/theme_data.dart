import 'package:e_learning_app_gp/config/themes/input_decoration_theme.dart';
import 'package:e_learning_app_gp/config/themes/theme.dart';
import 'package:flutter/material.dart';

ThemeData lightThemeData = ThemeData.light().copyWith(
  //-
  textSelectionTheme: textSelectionThemeData,
  inputDecorationTheme: lightInputDecorationTheme,
  //-
  colorScheme: const ColorScheme.light(
    primary: MyTheme.primaryColor,
    onPrimary: Colors.white,
    //-
    surface: MyTheme.surfaceColor,
    onSurface: MyTheme.textColor,
  ),
);

ThemeData darkThemeData = ThemeData.dark().copyWith(
  //-
  textSelectionTheme: textSelectionThemeData,
  inputDecorationTheme: darkInputDecorationTheme,
  //-
  colorScheme: const ColorScheme.dark(
    primary: MyTheme.primaryColor,
    onPrimary: Colors.white,
    //-
    surface: MyTheme.surfaceColor,
    onSurface: MyTheme.textColor,
  ),
);

TextSelectionThemeData textSelectionThemeData = TextSelectionThemeData(
  selectionColor: MyTheme.primaryColor.withOpacity(0.4),
  selectionHandleColor: MyTheme.primaryColor,
  cursorColor: MyTheme.primaryColor,
);
