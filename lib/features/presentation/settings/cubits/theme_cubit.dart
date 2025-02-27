import 'package:ElevatED/core/constants/enum.dart';
import 'package:ElevatED/core/helper/theme_helpers.dart';
import 'package:ElevatED/features/data_sources/local/disk_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'package:ElevatED/features/presentation/settings/states/theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit(this._diskCache, this._themeHelpers)
      : super(const ThemeInitial(ThemeModes.system)) {
    final int? themeMode = _diskCache.getThemeMode();
    if (themeMode != null) {
      emit(ThemeChanged(ThemeModes.values[themeMode]));
    }
  }
  final DiskCache _diskCache;
  final ThemeHelpers _themeHelpers;

  void changeTheme(BuildContext context, ThemeModes themeMode) {
    _diskCache.saveThemeMode(themeMode);
    _themeHelpers.getCurrentTheme();
    emit(ThemeChanged(themeMode));
  }
}
