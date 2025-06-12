import 'dart:ui';

import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:ElevatED/core/constants/app_keys.dart';
import 'package:ElevatED/core/constants/enum.dart';
import 'package:ElevatED/core/services/Shared%20Preferences%20Service/shared_preferences_service.dart';
import 'package:themed/themed.dart';

class ThemeService {
  final SharedPreferencesService sharedPrefsManager;
  ThemeService(this.sharedPrefsManager);

  void init() {
    PlatformDispatcher.instance.onPlatformBrightnessChanged = () {
      final theme = getThemeData();
      Themed.currentTheme = theme;
    };
  }

  Map<ThemeRef, Object>? getThemeData() {
    Map<ThemeRef, Object>? theme;

    int? themeModeIndex = sharedPrefsManager.getInt(AppKeys.themeKey);

    ThemeEnum themeMode = ThemeEnum.values[themeModeIndex ?? 2];

    theme = _getThemeDataByEnum(themeMode);

    return theme;
  }

  Future<void> changeTheme(ThemeEnum themeEnum) async {
    Map<ThemeRef, Object>? theme;
    theme = _getThemeDataByEnum(themeEnum);
    Themed.currentTheme = theme;
    await saveTheme(themeEnum);
  }

  Future<void> saveTheme(ThemeEnum theme) async {
    await sharedPrefsManager.setInt(AppKeys.themeKey, theme.index);
  }

  ThemeEnum getThemeEnum() {
    int? themeModeIndex = sharedPrefsManager.getInt(AppKeys.themeKey);
    return ThemeEnum.values[themeModeIndex ?? 2];
  }

  Map<ThemeRef, Object>? _getThemeDataByEnum(ThemeEnum themeMode) {
    switch (themeMode) {
      case ThemeEnum.system:
        return _getThemeDataByBrightness();
      case ThemeEnum.dark:
        return newDarkTheme;
      case ThemeEnum.light:
        return null;
    }
  }

  Map<ThemeRef, Object>? _getThemeDataByBrightness() {
    final brightness = PlatformDispatcher.instance.platformBrightness;
    switch (brightness) {
      case Brightness.light:
        return null;
      case Brightness.dark:
        return newDarkTheme;
    }
  }
}
