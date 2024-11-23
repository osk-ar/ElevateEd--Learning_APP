import 'package:flutter/material.dart';

class AppColors {
  //* main colors
  static const Color primaryColor = Color(0xFF7B61FF);
  static const Color darkPrimaryColor = Color(0xFF322885);

// On color 80, 60.... those means opacity

  static const MaterialColor primaryMaterialColor =
  MaterialColor(0xFF9581FF, <int, Color>{
    50: Color(0xFFEFECFF),
    100: Color(0xFFD7D0FF),
    200: Color(0xFFBDB0FF),
    300: Color(0xFFA390FF),
    400: Color(0xFF8F79FF),
    500: Color(0xFF7B61FF),
    600: Color(0xFF7359FF),
    700: Color(0xFF684FFF),
    800: Color(0xFF5E45FF),
    900: Color(0xFF6C56DD),
  });

  static const MaterialColor darkPrimaryMaterialColor =
  MaterialColor(0xFF2D2A57, <int, Color>{
    50: Color(0xFFE8E7F1),
    100: Color(0xFFC6C3E0),
    200: Color(0xFFA19ACD),
    300: Color(0xFF7C72BA),
    400: Color(0xFF6158AC),
    500: Color(0xFF463F9E),
    600: Color(0xFF413999),
    700: Color(0xFF39308F),
    800: Color(0xFF322885),
    900: Color(0xFF141028),
  });


  static const Color transparentColor = Colors.transparent;

  static const Color blackColor = Color(0xFF16161E);
  static const Color blackColor80 = Color(0xCC000000);
  static const Color blackColor60 = Color(0x99000000);
  static const Color blackColor40 = Color(0xFFA2A2A5);
  static const Color blackColor20 = Color(0xFFD0D0D2);
  static const Color blackColor10 = Color(0xFFE8E8E9);
  static const Color blackColor5 = Color(0xFFF3F3F4);
  static const Color lightGrayColor = Color(0xFFD9D9D9);

  static const Color whiteColor = Color(0xFFF8F8F8);
  static const Color whiteColor80 = Color(0xFFCCCCCC);
  static const Color whiteColor60 = Color(0xFF999999);
  static const Color whiteColor40 = Color(0xFF666666);
  static const Color whiteColor20 = Color(0xFF333333);
  static const Color whiteColor10 = Color(0xFF191919);
  static const Color whiteColor5 = Color(0xFF0D0D0D);

  static const Color greyColor = Color(0xFFB8B5C3);
  static const Color lightGreyColor = Color(0xFFF8F8F9);
  static const Color darkGreyColor = Color(0xFF1C1C25);
// static const Color greyColor80 = Color(0xFFC6C4CF);
// static const Color greyColor60 = Color(0xFFD4D3DB);
// static const Color greyColor40 = Color(0xFFE3E1E7);
// static const Color greyColor20 = Color(0xFFF1F0F3);
// static const Color greyColor10 = Color(0xFFF8F8F9);
// static const Color greyColor5 = Color(0xFFFBFBFC);

  static const Color purpleColor = Color(0xFF6849FF);
  static const Color purpleColor50 = Color(0xFF8369FA);
  static const Color purpleColor30 = Color(0xFFCDC4FB);
  static const Color purpleColor10 = Color(0xFFEEECF4);
  static const Color lightPurpleColor = Color(0xFFB7A8FF);
  static const Color buttonPurpleColor = Color(0xFFd4d0f7);

  static const Color darkPurpleColor50 = Color(0xFF000000);
  static const Color darkPurpleColor30 = Color(0xFF141028);
  static const Color darkPurpleColor10 = Color(0xFF5F4DBE);
  static const Color orange = Color(0xFFFF5722);
  static const Color orangeAccent = Color(0xFFFBA444);
  static const Color darkPurple = Color(0xFFB193E2);
  static const Color deepDarkPurple = Color(0xFF664ED1);
  static const Color gold = Color(0xFFFFD54B);
  static const Color silver = Color(0xFFE1E1E2);
  static const Color bronze = Color(0xFFF6B191);
  static const Color gray = Color(0x8095989A);
  static const Color softRed = Color(0xFFECCBD7);





  static const Color successColor = Color(0xFF2ED573);
  static const Color warningColor = Color(0xFFFFBE21);
  static const Color errorColor = Color(0xFFEA5B5B);

  static const Color appbar_top = Color(0xff8a72f9);
  static const Color appbar_bottom = Color(0xff9b86fa);
  static const Color under_appbar_shadow = Color(0xffa391fb);



  // static const Color yellow = Color(0xfff5d100);
  // static const Color red = Color(0xffae2012);
  // static const Color green = Color(0xff344e41);
  // static const Color darkGrey = Color(0xff1f1f1d);
  // static const Color grey = Color(0xff737477);
  // static const Color lightGrey = Color(0xff9E9E9E);
  // static const Color black = Color(0xff020005);
  // static const Color nearlyBlack = Color(0xFF213333);
  // static const Color white = Color(0xffFFFFFF);
  // static const Color cream = Color(0xffe9d8a6);
  // static const Color violet = Color(0xff5a189a);
  static const Color blueColor = Color(0xff004CFF);
  // static const Color nearlyWhite = Color(0x07000000);
  // static const Color hintColor = Color(0xFF707070);
  // static const Color transparent = Color(0x00000000);
  //
  // static const Color darkPrimary = Color(0xfff0a320);
  // static const Color lightPrimary = Color(0xCCd17d11); // color with 80% opacity
  // static const Color grey1 = Color(0xff707070);
  // static const Color grey2 = Color(0xff797979);





  // static const Color menuBackground = Color(0xFF090912);
  // static const Color itemsBackground = Color(0xFF1B2339);
  // static const Color pageBackground = Color(0xFF282E45);
  // static const Color mainTextColor1 = Colors.white;
  // static const Color mainTextColor2 = Colors.white70;
  // static const Color mainTextColor3 = Colors.white38;
  // static const Color mainGridLineColor = Colors.white10;
  // static const Color borderColor = Colors.white54;
  // static const Color gridLinesColor = Color(0xFFFFFFFF);
  //
  // static const Color contentColorBlack = Colors.black;
  // static const Color contentColorWhite = Colors.white;
  // static const Color contentColorBlue = Color(0xFF2196F3);
  // static const Color contentColorYellow = Color(0xFFFFC300);
  // static const Color contentColorOrange = Color(0xFFFF683B);
  // static const Color contentColorGreen = Color(0xFF3BFF49);
  // static const Color contentColorPurple = Color(0xFF6E1BFF);
  // static const Color contentColorPink = Color(0xFFFF3AF2);
  // static const Color contentColorRed = Color(0xFFE80054);
  // static const Color contentColorCyan = Color(0xFF50E4FF);

}
