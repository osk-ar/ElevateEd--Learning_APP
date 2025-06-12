import 'package:ElevatED/core/constants/enum.dart';
import 'package:ElevatED/core/services/Language%20Service/language_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'package:ElevatED/features/presentation/settings/states/language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  final LanguageService _languageService;
  LanguageCubit(this._languageService)
      : super(LanguageInitial(_languageService.appLanguage));

  void changeLanguage(BuildContext context, LanguageEnum language) {
    _languageService.setLangugae(context, language);
    emit(LanguageChanged(language));
  }
}
