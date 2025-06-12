import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:ElevatED/core/constants/enum.dart';
import 'package:ElevatED/core/constants/app_colors.dart';
import 'package:ElevatED/features/presentation/0_common/default_appbar.dart';
import 'package:ElevatED/features/presentation/settings/cubits/language_cubit.dart';
import 'package:ElevatED/features/presentation/settings/screens/widgets/settings_option_tile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.backgroundColor,
      appBar: defaultAppbar("language".tr()),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
          child: BlocBuilder<LanguageCubit, LanguageState>(
            builder: (context, state) {
              return ListView.separated(
                itemCount: LanguageEnum.values.length,
                separatorBuilder: (context, index) {
                  return SizedBox(height: 24.h);
                },
                itemBuilder: (_, index) {
                  return SettingOptionTile(
                    title: LanguageEnum.values[index].name.tr(),
                    foregroundColor: AppColors.whiteColor,
                    isSelected: index == state.language.index,
                    onTap: () {
                      context
                          .read<LanguageCubit>()
                          .changeLanguage(context, LanguageEnum.values[index]);
                    },
                  );
                },
              );
            },
          )),
    );
  }
}
