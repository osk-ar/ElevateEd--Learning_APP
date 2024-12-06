import 'package:e_learning_app_gp/config/themes/theme.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_fonts.dart';
import 'app_styles.dart';
import 'language_manager.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle customButtonTextStyle(BuildContext context,
          {double? fontSize, Color? color}) =>
      getBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: color ?? MyTheme.inverseTextColor,
        fontSize: fontSize ?? FontSize.f20,
      );

  static TextStyle onBoardingLightTextStyle(BuildContext context) =>
      getLightStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: AppColors.blackColor,
        fontSize: FontSize.f36,
      );

  static TextStyle onBoardingBoldTextStyle(BuildContext context) =>
      getMediumStyle(
          fontFamily: AppLanguages.getPrimaryFont(context),
          color: MyTheme.primaryColor,
          fontSize: FontSize.f36,
          letterSpacing: 1);

  static TextStyle semiBoldHintTextStyle(BuildContext context) =>
      getMediumStyle(
          fontFamily: AppLanguages.getPrimaryFont(context),
          color: MyTheme.hintTextColor,
          fontSize: FontSize.f16);

  static TextStyle textButtonTextStyle(BuildContext context) => getBoldStyle(
      fontFamily: AppLanguages.getPrimaryFont(context),
      color: MyTheme.primaryColor,
      fontSize: FontSize.f16);

//! should update all to use this
  static TextStyle lightTextStyle(BuildContext context,
          {double? fontSize, Color? color}) =>
      getLightStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: color ?? MyTheme.textColor,
        fontSize: fontSize ?? FontSize.f20,
      );
  static TextStyle regularTextStyle(BuildContext context,
          {double? fontSize, Color? color}) =>
      getRegularStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: color ?? MyTheme.textColor,
        fontSize: fontSize ?? FontSize.f20,
      );
  static TextStyle mediumTextStyle(BuildContext context,
          {double? fontSize, Color? color}) =>
      getMediumStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: color ?? MyTheme.textColor,
        fontSize: fontSize ?? FontSize.f20,
      );
  static TextStyle boldTextStyle(BuildContext context,
          {double? fontSize, Color? color}) =>
      getBoldStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: color ?? MyTheme.textColor,
        fontSize: fontSize ?? FontSize.f20,
      );
  static TextStyle blackTextStyle(BuildContext context,
          {double? fontSize, Color? color}) =>
      getBlackStyle(
        fontFamily: AppLanguages.getPrimaryFont(context),
        color: color ?? MyTheme.textColor,
        fontSize: fontSize ?? FontSize.f20,
      );
}
