import 'package:ElevatED/config/routes/route_constants.dart';
import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:ElevatED/config/extensions.dart';
import 'package:ElevatED/core/constants/app_colors.dart';
import 'package:ElevatED/config/themes/text_styles.dart';
import 'package:ElevatED/core/constants/app_assets.dart';
import 'package:ElevatED/features/presentation/0_common/cta_icon_button.dart';
import 'package:ElevatED/features/presentation/0_common/double_circular_avatar.dart';
import 'package:ElevatED/features/presentation/0_common/expandable_text.dart';
import 'package:ElevatED/features/data/data sources/cache/memory_cache.dart';
import 'package:ElevatED/features/data/models/user_data.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StudentProfileScreen extends StatelessWidget {
  const StudentProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userData = MemoryCache.getUserData() as StudentUserData;

    return SafeArea(
      child: Scaffold(
        backgroundColor: ThemeColors.backgroundColor,
        body: CustomScrollView(slivers: [
          SliverToBoxAdapter(
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      ImageAssets.default_cover,
                      height: 202.5.h,
                      fit: BoxFit.cover,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(width: 105.w),
                        SizedBox(
                          width: 150.w,
                          child: Text(
                            userData.name,
                            overflow: TextOverflow.ellipsis,
                            style: getMediumStyle(
                                fontSize: 16.sp, color: ThemeColors.textColor),
                          ),
                        ),
                        const Spacer(),
                        CTAIconButton(
                          icon: Icons.edit_rounded,
                          onPressed: () {
                            context.pushNamed(
                                RouteConstants.editProfileScreenRoute);
                          },
                        ),
                        SizedBox(width: 5.w),
                        CTAIconButton(
                          icon: Icons.settings_rounded,
                          onPressed: () {
                            context
                                .pushNamed(RouteConstants.settingsScreenRoute);
                          },
                        ),
                      ],
                    ),
                    // No professional title for students
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                      child: ExpandableText(text: userData.description),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        spacing: 8.h,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8.h),
                          Text(
                            'personal_info'.tr(),
                            overflow: TextOverflow.ellipsis,
                            style: getMediumStyle(
                                fontSize: 16.sp, color: ThemeColors.textColor),
                          ),
                          Column(
                            children: [
                              _buildTopTile(
                                icon: Icons.email_rounded,
                                title: "Email",
                                value: userData.email,
                              ),
                              _buildCenterTile(
                                icon: Icons.phone_rounded,
                                title: "Phone",
                                value: userData.phone,
                              ),
                              _buildBottomTile(
                                icon: Icons.favorite_rounded,
                                title: "Interests",
                                value: userData.interests
                                    .map((e) => e.name)
                                    .join(', '),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 153.h,
                  left: context.locale != const Locale('ar') ? 5.w : null,
                  right: context.locale == const Locale('ar') ? 5.w : null,
                  child: DoubleCircularAvatar(
                    outerRadius: 50.r,
                    innerRadius: 45.r,
                    imageURL: userData.profilePictureUrl,
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }

  Widget _buildTopTile(
      {required IconData icon, required String title, required String value}) {
    return ListTile(
      tileColor: ThemeColors.lightSurfaceToDarkSecondary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.r),
          topRight: Radius.circular(10.r),
        ),
        side: const BorderSide(
            width: 1,
            color: AppColors.blackColor,
            strokeAlign: BorderSide.strokeAlignOutside),
      ),
      leading: Icon(icon, color: AppColors.primaryColor),
      title: Text(
        title,
        style: getSemiBoldStyle(fontSize: 14.sp, color: AppColors.whiteColor),
      ),
      trailing: Text(
        value,
        style: getMediumStyle(fontSize: 14.sp, color: AppColors.whiteColor),
      ),
    );
  }

  Widget _buildCenterTile(
      {required IconData icon, required String title, required String value}) {
    return ListTile(
      tileColor: ThemeColors.lightSurfaceToDarkSecondary,
      shape: const RoundedRectangleBorder(
        side: BorderSide(
            width: 1,
            color: AppColors.blackColor,
            strokeAlign: BorderSide.strokeAlignOutside),
      ),
      leading: Icon(icon, color: AppColors.primaryColor),
      title: Text(
        title,
        style: getSemiBoldStyle(fontSize: 14.sp, color: AppColors.whiteColor),
      ),
      trailing: Text(
        value,
        style: getMediumStyle(fontSize: 14.sp, color: AppColors.whiteColor),
      ),
    );
  }

  Widget _buildBottomTile(
      {required IconData icon, required String title, required String value}) {
    return ListTile(
      tileColor: ThemeColors.lightSurfaceToDarkSecondary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10.r),
          bottomRight: Radius.circular(10.r),
        ),
        side: const BorderSide(
            width: 1,
            color: AppColors.blackColor,
            strokeAlign: BorderSide.strokeAlignOutside),
      ),
      leading: Icon(icon, color: AppColors.primaryColor),
      title: Text(
        title,
        style: getSemiBoldStyle(fontSize: 14.sp, color: AppColors.whiteColor),
      ),
      trailing: Text(
        value,
        style: getMediumStyle(fontSize: 14.sp, color: AppColors.whiteColor),
      ),
    );
  }
}
