import 'dart:ui';

import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:ElevatED/core/constants/enum.dart';
import 'package:ElevatED/features/data_sources/local/disk_cache.dart';
import 'package:themed/themed.dart';

class ThemeHelpers {
  final DiskCache _diskCache;
  ThemeHelpers(this._diskCache);

  Map<ThemeRef, Object>? getCurrentTheme() {
    int? themeModeIndex = _diskCache.getThemeMode();
    if (themeModeIndex == null) return null;
    ThemeModes themeMode = ThemeModes.values[themeModeIndex];
    final theme = getTheme(themeMode);
    Themed.currentTheme = theme;

    return theme;
  }

  Map<ThemeRef, Object>? getTheme(ThemeModes themeMode) {
    switch (themeMode) {
      case ThemeModes.system:
        return getThemeByBrightness();
      case ThemeModes.dark:
        return newDarkTheme;
      case ThemeModes.light:
        return null;
    }
  }

  Map<ThemeRef, Object>? getThemeByBrightness() {
    final brightness = PlatformDispatcher.instance.platformBrightness;
    switch (brightness) {
      case Brightness.light:
        return null;
      case Brightness.dark:
        return newDarkTheme;
    }
  }
}
