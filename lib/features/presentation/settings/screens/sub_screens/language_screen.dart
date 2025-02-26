import 'package:ElevatED/core/constants/enum.dart';
import 'package:ElevatED/core/resources/app_colors.dart';
import 'package:ElevatED/core/resources/language_manager.dart';
import 'package:ElevatED/features/data_sources/local/disk_cache.dart';
import 'package:ElevatED/features/presentation/common/default_appbar.dart';
import 'package:ElevatED/features/presentation/settings/screens/widgets/settings_option_tile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LanguageScreen extends StatelessWidget {
  final DiskCache _diskCache;
  const LanguageScreen(this._diskCache, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppbar("Language"),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: ListView.separated(
            itemCount: 2,
            separatorBuilder: (context, index) {
              return SizedBox(height: 24.h);
            },
            itemBuilder: (_, index) {
              return SettingOptionTile(
                title:
                    AppLanguages.languageEnumToString(Languages.values[index]),
                foregroundColor: AppColors.whiteColor,
                isSelected: index == 1,
                onTap: () {
                  _diskCache.saveLanguage(Languages.values[index]);
                  context.setLocale(Locale(Languages.values[index].name, ''));
                },
              );
            }),
      ),
    );
  }
}
