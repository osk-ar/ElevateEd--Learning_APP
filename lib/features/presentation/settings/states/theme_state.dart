part of 'package:ElevatED/features/presentation/settings/cubits/theme_cubit.dart';

class ThemeState extends Equatable {
  const ThemeState(this.themeMode);
  final ThemeModes themeMode;

  @override
  List<Object?> get props => [themeMode];
}

class ThemeInitial extends ThemeState {
  const ThemeInitial(super.themeMode);

  @override
  List<Object?> get props => [themeMode];
}

class ThemeChanged extends ThemeState {
  const ThemeChanged(super.themeMode);

  @override
  List<Object?> get props => [themeMode];
}
