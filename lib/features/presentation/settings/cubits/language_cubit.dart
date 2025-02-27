import 'package:ElevatED/core/constants/enum.dart';
import 'package:ElevatED/features/data_sources/local/disk_cache.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'package:ElevatED/features/presentation/settings/states/language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit(this._diskCache) : super(const LanguageInitial(Languages.en)) {
    final int? language = _diskCache.getLanguage();
    if (language != null) {
      emit(LanguageChanged(Languages.values[language]));
    }
  }
  final DiskCache _diskCache;

  void changeLanguage(BuildContext context, Languages language) {
    _diskCache.saveLanguage(language);
    context.setLocale(Locale(language.name, ''));
    emit(LanguageChanged(language));
  }
}
