import 'package:flutter/material.dart';
import 'package:themed/themed.dart';

class MyTheme {
  static const backgroundColor = ColorRef(Color(0xFFF2F2F2));
  static const primaryColor = ColorRef(Color(0xFF2889FB));
  static const secondaryColor = ColorRef(Color(0xFF50A0FF));

  static const textColor = ColorRef(Colors.black);
  static const inverseTextColor = ColorRef(Colors.white);
  static final hintTextColor = ColorRef(Colors.grey[500]);
}

Map<ThemeRef, Object> lightTheme = {
  // MyTheme.backgroundColor: const Color(0xFFF2F2F2),
};

Map<ThemeRef, Object> darkTheme = {
  MyTheme.backgroundColor: const Color(0xFF1E1E1E),
  MyTheme.textColor: Colors.white,
  MyTheme.inverseTextColor: Colors.black,
};
