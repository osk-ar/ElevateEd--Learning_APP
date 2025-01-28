import 'package:flutter/material.dart';

import 'app_fonts.dart';

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
// TextStyle getThinStyle(
//     {fontFamily = FontConstants.primaryEnglishFont, fontSize = FontSize.f12, required Color color, List<Shadow>? shadows}) {
//   return _getTextStyle(fontFamily, fontSize, FontWeightManager.thin, color, shadows);
// }

// extraLight style
// TextStyle getExtraLightStyle(
//     {fontFamily = FontConstants.primaryEnglishFont, fontSize = FontSize.f12, required Color color, List<Shadow>? shadows}) {
//   return _getTextStyle(fontFamily, fontSize, FontWeightManager.extraLight, color, shadows);
// }

// light style
TextStyle getLightStyle(
    {fontFamily = FontConstants.primaryEnglishFont,
    required double fontSize,
    required Color color,
    List<Shadow>? shadows,
    double? letterSpacing}) {
  return _getTextStyle(fontFamily, fontSize, FontWeightManager.light, color,
      shadows, letterSpacing);
}

// regular style
TextStyle getRegularStyle(
    {fontFamily = FontConstants.primaryEnglishFont,
    required double fontSize,
    required Color color,
    List<Shadow>? shadows,
    double? letterSpacing}) {
  return _getTextStyle(fontFamily, fontSize, FontWeightManager.regular, color,
      shadows, letterSpacing);
}

// medium style
TextStyle getMediumStyle(
    {fontFamily = FontConstants.primaryEnglishFont,
    required double fontSize,
    required Color color,
    List<Shadow>? shadows,
    double? letterSpacing}) {
  return _getTextStyle(fontFamily, fontSize, FontWeightManager.medium, color,
      shadows, letterSpacing);
}

// semiBold style
TextStyle getSemiBoldStyle(
    {fontFamily = FontConstants.primaryEnglishFont,
    required double fontSize,
    required Color color,
    List<Shadow>? shadows,
    double? letterSpacing}) {
  return _getTextStyle(fontFamily, fontSize, FontWeightManager.bold, color,
      shadows, letterSpacing);
}

// bold style
TextStyle getBoldStyle(
    {fontFamily = FontConstants.primaryEnglishFont,
    required double fontSize,
    required Color color,
    List<Shadow>? shadows,
    double? letterSpacing}) {
  return _getTextStyle(fontFamily, fontSize, FontWeightManager.bold, color,
      shadows, letterSpacing);
}

// extraBold style
// TextStyle getExtraBoldStyle(
//     {fontFamily = FontConstants.primaryEnglishFont, double fontSize = FontSize.f12, required Color color, List<Shadow>? shadows}) {
//   return _getTextStyle(fontFamily, fontSize, FontWeightManager.extraBold, color, shadows,);
// }

// black style
TextStyle getBlackStyle(
    {fontFamily = FontConstants.primaryEnglishFont,
    required double fontSize,
    required Color color,
    List<Shadow>? shadows,
    double? letterSpacing}) {
  return _getTextStyle(fontFamily, fontSize, FontWeightManager.black, color,
      shadows, letterSpacing);
}
