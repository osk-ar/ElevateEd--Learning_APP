import 'package:flutter/material.dart';
import 'package:themed/themed.dart';

class MyTheme {
  static const backgroundColor = ColorRef(Colors.white, id: 'backgroundColor');
  static const backgroundColor1 = ColorRef(Color(0xFF8269F8));
  static const backgroundColor2 = ColorRef(Color(0xFFCCC3F9));
  static const backgroundColor3 = ColorRef(Color(0xFFECEBF2));

  /// Home Screen
  static const appbarTop = ColorRef(Color(0xff8a72f9));
  static const appbarBottom = ColorRef(Color(0xff9b86fa));
  static const appbarShadow = ColorRef(Color(0xffa391fb));
  static  ColorRef contentCardBG = ColorRef(const Color(0xffFFFFFF).withOpacity(0.60));
 /// Game Screen
  static const timerBarColor = ColorRef(Color(0xFF525160));
  static const answersCardColor = ColorRef(Color(0xFFA991D2));
  static const answersCardBorderColor = ColorRef(Color(0xFF2F2E41));



  static const inputColor = ColorRef(Color(0x33A6A6A6));


  static const navigationBarForeground =
      ColorRef(Color(0xFFB7A9FD), id: "navigationBarBackground");
  static const navigationBarBackground =
      ColorRef(Color(0xFFECEBF2), id: "navigationBarForeground");

  static const textColor = ColorRef(Colors.black, id: 'textColor');

  static const reverseColor = ColorRef(Colors.black, id: 'reverseColor');

  static const primaryButtonColor =
      ColorRef(Color(0xFF6C63FD), id: 'primaryButton');
  static const secondaryButtonColor =
      ColorRef(Color(0xFFD4D0F5), id: 'secondaryButton');

  static const primaryButtonTextColor =
      ColorRef(Colors.white, id: 'buttonTextColor');
  static const secondaryButtonTextColor =
      ColorRef(Color(0xFF6960FB), id: 'onButton');

  static const selectedBorder =
      ColorRef(Color(0xFF958EFF), id: 'selectedBorder');

  static const studentSelectColor = ColorRef(Color(0xFF7B61FD), id: 'teacher');
  static const teacherSelectColor = ColorRef(Color(0xFFFDB461), id: 'student');

  static const disabledColor = ColorRef(Color(0xFF757575), id: 'disabled');

  static const mainText = TextStyleRef(
    TextStyle(
      fontWeight: FontWeight.bold,
      color: textColor,
    ),
  );
}

Map<ThemeRef, Object> LightTheme = {
  MyTheme.backgroundColor: Colors.white,
  MyTheme.reverseColor: Colors.white,
  MyTheme.textColor: Colors.black,
};

Map<ThemeRef, Object> DarkTheme = {
  MyTheme.backgroundColor: const Color(0xFF141028),
  MyTheme.backgroundColor1: const Color(0xff5f4dbe),
  MyTheme.backgroundColor2: const Color(0xFF141028),
  MyTheme.backgroundColor3: const Color(0xFF141028),

  /// Home
  MyTheme.appbarTop: const Color(0xFF4b3b99),
  MyTheme.appbarBottom: const Color(0xFF3F3280),
  MyTheme.appbarShadow: const Color(0xFF3F3280),
  MyTheme.contentCardBG: const Color(0xFF525151).withOpacity(0.35),

  /// Game
  MyTheme.answersCardColor: const Color(0xFF35284E),
  MyTheme.answersCardBorderColor: const Color(0xFF7A68FF),

  MyTheme.textColor: Colors.white,
  MyTheme.reverseColor: Colors.black,

  MyTheme.navigationBarBackground: const Color(0xFF141028),
  MyTheme.navigationBarForeground: const Color(0xff2b1c77),

  MyTheme.secondaryButtonColor: const Color(0xFF181636),

  MyTheme.inputColor: Color(0x28FFFFFF),
};

Map<ThemeRef, Object> BlueTheme = {
  MyTheme.backgroundColor: const Color(0xFFE3F2FD),
  MyTheme.backgroundColor1: const Color(0xFFBBDEFB),
  MyTheme.backgroundColor2: const Color(0xFF90CAF9),
  MyTheme.backgroundColor3: const Color(0xFF64B5F6),

  // Home
  MyTheme.appbarTop: const Color(0xFF2196F3),
  MyTheme.appbarBottom: const Color(0xFF1976D2),
  MyTheme.appbarShadow: const Color(0xFF1E88E5),

  MyTheme.contentCardBG: const Color(0xFFE1F5FE).withOpacity(0.60),

  MyTheme.textColor: Colors.blueGrey,
  MyTheme.reverseColor: Colors.white,

  MyTheme.primaryButtonColor: const Color(0xFF0288D1),
  MyTheme.secondaryButtonColor: const Color(0xFFB3E5FC),

  MyTheme.primaryButtonTextColor: Colors.white,
  MyTheme.secondaryButtonTextColor: const Color(0xFF01579B),

  MyTheme.selectedBorder: const Color(0xFF0288D1),

  MyTheme.studentSelectColor: const Color(0xFF4FC3F7),
  MyTheme.teacherSelectColor: const Color(0xFF03A9F4),

  MyTheme.disabledColor: const Color(0xFF90A4AE),
};