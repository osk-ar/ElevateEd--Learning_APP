import 'package:flutter/material.dart';

import '../../core/constants/app_fonts.dart';

TextStyle _getTextStyle(
    String fontFamily,
    double fontSize,
    FontWeight fontWeight,
    Color color,
    List<Shadow>? shadows,
    double? letterSpacing) {
  return TextStyle(
      fontSize: fontSize,
      fontFamily: fontFamily,
      color: color,
      fontWeight: fontWeight,
      shadows: shadows,
      letterSpacing: letterSpacing);
}

// thin style
TextStyle getThinStyle(
    {fontFamily = FontConstants.primaryFont,
    required double fontSize,
    required Color color,
    List<Shadow>? shadows,
    double? letterSpacing}) {
  return _getTextStyle(fontFamily, fontSize, FontWeightManager.thin, color,
      shadows, letterSpacing);
}

// extraLight style
TextStyle getExtraLightStyle(
    {fontFamily = FontConstants.primaryFont,
    required double fontSize,
    required Color color,
    List<Shadow>? shadows,
    double? letterSpacing}) {
  return _getTextStyle(fontFamily, fontSize, FontWeightManager.extraLight,
      color, shadows, letterSpacing);
}

// light style
TextStyle getLightStyle(
    {fontFamily = FontConstants.primaryFont,
    required double fontSize,
    required Color color,
    List<Shadow>? shadows,
    double? letterSpacing}) {
  return _getTextStyle(fontFamily, fontSize, FontWeightManager.light, color,
      shadows, letterSpacing);
}

// regular style
TextStyle getRegularStyle(
    {fontFamily = FontConstants.primaryFont,
    required double fontSize,
    required Color color,
    List<Shadow>? shadows,
    double? letterSpacing}) {
  return _getTextStyle(fontFamily, fontSize, FontWeightManager.regular, color,
      shadows, letterSpacing);
}

// medium style
TextStyle getMediumStyle(
    {fontFamily = FontConstants.primaryFont,
    required double fontSize,
    required Color color,
    List<Shadow>? shadows,
    double? letterSpacing}) {
  return _getTextStyle(fontFamily, fontSize, FontWeightManager.medium, color,
      shadows, letterSpacing);
}

// semiBold style
TextStyle getSemiBoldStyle(
    {fontFamily = FontConstants.primaryFont,
    required double fontSize,
    required Color color,
    List<Shadow>? shadows,
    double? letterSpacing}) {
  return _getTextStyle(fontFamily, fontSize, FontWeightManager.semiBold, color,
      shadows, letterSpacing);
}

// bold style
TextStyle getBoldStyle(
    {fontFamily = FontConstants.primaryFont,
    required double fontSize,
    required Color color,
    List<Shadow>? shadows,
    double? letterSpacing}) {
  return _getTextStyle(fontFamily, fontSize, FontWeightManager.bold, color,
      shadows, letterSpacing);
}

// extraBold style
TextStyle getExtraBoldStyle(
    {fontFamily = FontConstants.primaryFont,
    required double fontSize,
    required Color color,
    List<Shadow>? shadows,
    double? letterSpacing}) {
  return _getTextStyle(fontFamily, fontSize, FontWeightManager.extraBold, color,
      shadows, letterSpacing);
}

// black style
TextStyle getBlackStyle(
    {fontFamily = FontConstants.primaryFont,
    required double fontSize,
    required Color color,
    List<Shadow>? shadows,
    double? letterSpacing}) {
  return _getTextStyle(fontFamily, fontSize, FontWeightManager.black, color,
      shadows, letterSpacing);
}
