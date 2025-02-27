import 'package:ElevatED/config/routes/route_constants.dart';
import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:ElevatED/core/helper/extensions.dart';
import 'package:ElevatED/core/resources/app_colors.dart';
import 'package:ElevatED/core/resources/assets_manager.dart';
import 'package:ElevatED/features/presentation/common/default_appbar.dart';
import 'package:ElevatED/features/presentation/settings/screens/widgets/settings_tile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
              iconPath: IconsAssets.languageIcon,
              foregroundColor: AppColors.whiteColor,
              onTap: () {
                context.pushNamed(Routes.languageSettingScreenRoute);
              },
            ),
            SettingTile(
              title: 'notification'.tr(),
              iconPath: IconsAssets.notificationsIcon,
              foregroundColor: AppColors.whiteColor,
              onTap: () {
                context.pushNamed(Routes.notificationsSettingScreenRoute);
              },
            ),
            SettingTile(
              title: 'theme'.tr(),
              iconPath: IconsAssets.themeIcon,
              foregroundColor: AppColors.whiteColor,
              onTap: () {
                context.pushNamed(Routes.themeSettingScreenRoute);
              },
            ),
            Divider(
              height: 2.h,
              thickness: 2.h,
              color: ThemeColors.secondaryColor,
            ),
            SettingTile(
              title: 'billing_details'.tr(),
              iconPath: IconsAssets.billingIcon,
              foregroundColor: AppColors.whiteColor,
              onTap: () {},
            ),
            SettingTile(
              title: 'change_password'.tr(),
              iconPath: IconsAssets.passwordIcon,
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
              iconPath: IconsAssets.privacyIcon,
              foregroundColor: AppColors.whiteColor,
              onTap: () {
                context.pushNamed(Routes.privacyPolicySettingScreenRoute);
              },
            ),
            SettingTile(
              title: 'community_guidelines'.tr(),
              iconPath: IconsAssets.guideLinesIcon,
              foregroundColor: AppColors.whiteColor,
              onTap: () {
                context.pushNamed(Routes.communityGuidelinesSettingScreenRoute);
              },
            ),
            const Spacer(),
            SettingTile(
              title: 'logout'.tr(),
              iconPath: IconsAssets.LogoutIcon,
              foregroundColor: AppColors.lightErrorColor,
              onTap: () {},
            ),
            const SizedBox(height: 0),
          ],
        ),
      ),
    );
  }
}
