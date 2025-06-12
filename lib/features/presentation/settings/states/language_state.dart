part of 'package:ElevatED/features/presentation/settings/cubits/language_cubit.dart';

class LanguageState extends Equatable {
  const LanguageState(this.language);
  final LanguageEnum language;

  @override
  List<Object?> get props => [language];
}

class LanguageInitial extends LanguageState {
  const LanguageInitial(super.language);

  @override
  List<Object?> get props => [language];
}

class LanguageChanged extends LanguageState {
  const LanguageChanged(super.language);

  @override
  List<Object?> get props => [language];
}
