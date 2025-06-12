import 'package:ElevatED/init.dart';
import 'package:flutter/material.dart';
import 'package:ElevatED/core/constants/enum.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;

class LanguageService {
  LanguageEnum appLanguage = LanguageEnum.en;

  final List<Locale> locals = [const Locale('en'), const Locale('ar')];
  final Locale startLocal = const Locale('en');
  final Locale fallBackLocal = const Locale('ar');
  String translationsPath = 'assets/translations';

  // methods

  void init(BuildContext context) {
    appLanguage = getLanguageEnum(context);
  }

  Future<void> setLangugae(BuildContext context, LanguageEnum language) async {
    appLanguage = language;
    await _changeLanguage(context);
  }

  Future<void> _changeLanguage(BuildContext context) async {
    switch (appLanguage) {
      case LanguageEnum.ar:
        final locale = locals.where((loc) => loc.languageCode == 'ar').first;
        context.setLocale(locale);
        break;
      case LanguageEnum.en:
        final locale = locals.where((loc) => loc.languageCode == 'en').first;
        context.setLocale(locale);
        break;
    }
    await engine.performReassemble();
  }

  // addons

  static String getLanguageCode(BuildContext context) {
    return context.locale.languageCode;
  }

  static LanguageEnum getLanguageEnum(BuildContext context) {
    switch (getLanguageCode(context)) {
      case 'ar':
        return LanguageEnum.ar;
      default:
        return LanguageEnum.en;
    }
  }

  static TextDirection getTextDirection(BuildContext context) {
    switch (getLanguageCode(context)) {
      case 'ar':
        return TextDirection.rtl;
      default:
        return TextDirection.ltr;
    }
  }

  static String languageEnumToString(LanguageEnum language) {
    switch (language) {
      case LanguageEnum.ar:
        return 'Arabic';
      case LanguageEnum.en:
        return 'English';
    }
  }
}
