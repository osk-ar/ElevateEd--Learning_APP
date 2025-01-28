import 'package:flutter/material.dart';
import 'package:themed/themed.dart';

class MyTheme {
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
  static const textColor = ColorRef(Color(0xFF000000), id: "textColor");
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

Map<ThemeRef, Object> lightTheme = {
  MyTheme.labelTextColor: const Color(0xFF2889FA),
};

Map<ThemeRef, Object> darkTheme = {
  MyTheme.surfaceColor: const Color(0xFF0C172B),
  MyTheme.onSurfaceColor: const Color(0xFF1F2833),
  MyTheme.secondaryColor: const Color(0xFF1F2833),
  MyTheme.onSecondaryColor: const Color(0xFFFFFFFF),
  MyTheme.backgroundColor: const Color(0xFF010A1B),
  MyTheme.textColor: const Color(0xFFFFFFFF),
  MyTheme.inverseTextColor: const Color(0xFF000000),
  MyTheme.backgroundGradientColor: const Color(0xF51F2833)
};
