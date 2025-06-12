import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:ElevatED/core/constants/app_colors.dart';
import 'package:ElevatED/config/themes/text_styles.dart';
import 'package:ElevatED/features/presentation/0_common/default_appbar.dart';
import 'package:ElevatED/features/presentation/settings/screens/widgets/paragraph_widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommunityGuidelinesPage extends StatelessWidget {
  const CommunityGuidelinesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppbar("community_guidelines".tr()),
      body: Padding(
        padding: EdgeInsets.all(16.0.r),
        child: ListView(
          children: [
            Text(
              'community_guidelines'.tr(),
              style:
                  getBoldStyle(fontSize: 24.sp, color: ThemeColors.textColor),
            ),
            SizedBox(height: 10.h),
            Text(
              'guidelines_rules_info'.tr(),
              style: getRegularStyle(
                  fontSize: 16.sp, color: ThemeColors.textColor),
            ),
            SizedBox(height: 20.h),
            sectionTitle('respect_and_inclusivity'.tr()),
            textBody('respect_and_inclusivity_info'.tr()),
            sectionTitle('academic_integrity'.tr()),
            textBody('academic_integrity_info'.tr()),
            sectionTitle('responsible_ai_use'.tr()),
            textBody('responsible_ai_use_info'.tr()),
            sectionTitle('group_chat_etiquette'.tr()),
            textBody('group_chat_etiquette_info'.tr()),
            sectionTitle('commenting_on_course_videos'.tr()),
            textBody('commenting_on_course_videos_info'.tr()),
            sectionTitle('reporting_violations'.tr()),
            textBody('reporting_violations_info'.tr()),
            sectionTitle('consequences_for_violations'.tr()),
            textBody('consequences_for_violations_info'.tr()),
            SizedBox(height: 20.h),
            Text(
              'guidelines_thanks'.tr(),
              style:
                  getBoldStyle(fontSize: 16.sp, color: AppColors.primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
