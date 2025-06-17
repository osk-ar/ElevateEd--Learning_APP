import 'package:ElevatED/config/routes/route_constants.dart';
import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:ElevatED/config/extensions.dart';
import 'package:ElevatED/core/constants/app_colors.dart';
import 'package:ElevatED/core/constants/app_icons.dart';
import 'package:ElevatED/features/presentation/0_common/default_appbar.dart';
import 'package:ElevatED/features/presentation/settings/screens/widgets/settings_tile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ElevatED/features/presentation/settings/cubits/auth_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.backgroundColor,
      appBar: defaultAppbar('settings'.tr()),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          spacing: 24.h,
          children: [
            const SizedBox(height: 0),
            SettingTile(
              title: 'language'.tr(),
              icon: AppIcons.language,
              foregroundColor: AppColors.whiteColor,
              onTap: () {
                context.pushNamed(RouteConstants.languageSettingScreenRoute);
              },
            ),
            SettingTile(
              title: 'notification'.tr(),
              icon: Icons.notifications_rounded,
              foregroundColor: AppColors.whiteColor,
              onTap: () {
                context
                    .pushNamed(RouteConstants.notificationsSettingScreenRoute);
              },
            ),
            SettingTile(
              title: 'theme'.tr(),
              icon: AppIcons.theme,
              foregroundColor: AppColors.whiteColor,
              onTap: () {
                context.pushNamed(RouteConstants.themeSettingScreenRoute);
              },
            ),
            Divider(
              height: 2.h,
              thickness: 2.h,
              color: ThemeColors.secondaryColor,
            ),
            SettingTile(
              title: 'billing_details'.tr(),
              icon: AppIcons.billing,
              foregroundColor: AppColors.whiteColor,
              onTap: () {},
            ),
            SettingTile(
              title: 'change_password'.tr(),
              icon: AppIcons.password,
              foregroundColor: AppColors.whiteColor,
              onTap: () {},
            ),
            Divider(
              height: 2.h,
              thickness: 2.h,
              color: ThemeColors.secondaryColor,
            ),
            SettingTile(
              title: 'privacy_policy'.tr(),
              icon: Icons.privacy_tip_rounded,
              foregroundColor: AppColors.whiteColor,
              onTap: () {
                context
                    .pushNamed(RouteConstants.privacyPolicySettingScreenRoute);
              },
            ),
            SettingTile(
              title: 'community_guidelines'.tr(),
              icon: AppIcons.guidelines,
              foregroundColor: AppColors.whiteColor,
              onTap: () {
                context.pushNamed(
                    RouteConstants.communityGuidelinesSettingScreenRoute);
              },
            ),
            const Spacer(),
            SettingTile(
              title: 'logout'.tr(),
              icon: Icons.logout_outlined,
              foregroundColor: AppColors.lightErrorColor,
              onTap: () {
                context.read<AuthCubit>().logout(context);
              },
            ),
            const SizedBox(height: 0),
          ],
        ),
      ),
    );
  }
}
