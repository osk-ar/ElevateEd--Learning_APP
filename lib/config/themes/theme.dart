import 'package:flutter/material.dart';
import 'package:themed/themed.dart';

class MyTheme {
  static const surfaceColor = ColorRef(Color(0xFFFFFFFF));

  static const backgroundColor = ColorRef(Color(0xFFE8E8E8));
  static const backgroundGradientColor = ColorRef(Color(0xF59AC8FF));

  static const primaryColor = ColorRef(Color(0xFF2889FB));
  static const secondaryColor = ColorRef(Color(0xFF9AC8FF));

  static const textColor = ColorRef(Colors.black);
  static const inverseTextColor =
      ColorRef(Colors.white, id: "inverseTextColor");
  static final hintTextColor = ColorRef(Colors.grey[500]);
}

Map<ThemeRef, Object> lightTheme = {};

Map<ThemeRef, Object> darkTheme = {
  MyTheme.surfaceColor: const Color(0xFF091223),
  MyTheme.secondaryColor: const Color(0xFF1F2833),
  MyTheme.backgroundColor: const Color(0xFF010A1B),
  MyTheme.textColor: Colors.white,
  MyTheme.inverseTextColor: Colors.black,
  MyTheme.backgroundGradientColor: const Color(0xF51F2833)
};
