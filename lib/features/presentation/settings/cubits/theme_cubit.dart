import 'package:ElevatED/core/constants/enum.dart';
import 'package:ElevatED/core/services/theme%20service/theme_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'package:ElevatED/features/presentation/settings/states/theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit(this._themeService) : super(const ThemeInitial(ThemeEnum.system)) {
    final int themeMode = _themeService.getThemeEnum().index;
    emit(ThemeChanged(ThemeEnum.values[themeMode]));
  }
  final ThemeService _themeService;

  void changeTheme(BuildContext context, ThemeEnum themeMode) {
    _themeService.changeTheme(themeMode);
    emit(ThemeChanged(themeMode));
  }
}
