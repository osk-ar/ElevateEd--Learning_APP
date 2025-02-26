import 'package:ElevatED/config/routes/route_constants.dart';
import 'package:ElevatED/config/themes/theme.dart';
import 'package:ElevatED/core/helper/extensions.dart';
import 'package:ElevatED/core/resources/app_colors.dart';
import 'package:ElevatED/core/resources/assets_manager.dart';
import 'package:ElevatED/features/presentation/common/default_appbar.dart';
import 'package:ElevatED/features/presentation/settings/screens/widgets/settings_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.backgroundColor,
      appBar: defaultAppbar('Settings'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SizedBox(height: 16.h),
            SettingTile(
              title: 'Language',
              iconPath: IconsAssets.languageIcon,
              foregroundColor: AppColors.whiteColor,
              onTap: () {
                context.pushNamed(Routes.multipleOptionSettingScreenRoute);
              },
            ),
            SizedBox(height: 24.h),
            SettingTile(
              title: 'Notification',
              iconPath: IconsAssets.notificationsIcon,
              foregroundColor: AppColors.whiteColor,
              onTap: () {},
            ),
            SizedBox(height: 24.h),
            SettingTile(
              title: 'Theme',
              iconPath: IconsAssets.themeIcon,
              foregroundColor: AppColors.whiteColor,
              onTap: () {},
            ),
            SizedBox(height: 24.h),
            Divider(
              height: 2.h,
              thickness: 2.h,
              color: ThemeColors.secondaryColor,
            ),
            SizedBox(height: 24.h),
            SettingTile(
              title: 'Billing Details',
              iconPath: IconsAssets.billingIcon,
              foregroundColor: AppColors.whiteColor,
              onTap: () {},
            ),
            SizedBox(height: 24.h),
            SettingTile(
              title: 'Change Password',
              iconPath: IconsAssets.passwordIcon,
              foregroundColor: AppColors.whiteColor,
              onTap: () {},
            ),
            SizedBox(height: 24.h),
            Divider(
              height: 2.h,
              thickness: 2.h,
              color: ThemeColors.secondaryColor,
            ),
            SizedBox(height: 24.h),
            SettingTile(
              title: 'Privacy Policy',
              iconPath: IconsAssets.privacyIcon,
              foregroundColor: AppColors.whiteColor,
              onTap: () {},
            ),
            SizedBox(height: 24.h),
            SettingTile(
              title: 'Community Guidelines',
              iconPath: IconsAssets.guideLinesIcon,
              foregroundColor: AppColors.whiteColor,
              onTap: () {},
            ),
            const Spacer(),
            SettingTile(
              title: 'Logout',
              iconPath: IconsAssets.LogoutIcon,
              foregroundColor: AppColors.lightErrorColor,
              onTap: () {},
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
