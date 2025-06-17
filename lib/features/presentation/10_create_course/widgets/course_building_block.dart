import 'package:ElevatED/config/themes/text_styles.dart';
import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:ElevatED/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseBuildingBlock extends StatelessWidget {
  const CourseBuildingBlock(
      {super.key,
      this.index = 0,
      this.title = "Unknown Default Test",
      required this.type});
  final int index;
  final String type;
  final String title;

  @override
  Widget build(BuildContext context) {
    // final String typeString = isVideo ? AppStrings.video : AppStrings.asign;
    return Container(
      padding: EdgeInsets.only(left: 12.w, right: 8.w, top: 4.h, bottom: 4.h),
      margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
      height: 48.h,
      decoration: BoxDecoration(
        color: ThemeColors.lightSurfaceToDarkSecondary,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: AppColors.primaryColor,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              "$index - $type - $title",
              style:
                  getMediumStyle(fontSize: 16.sp, color: AppColors.whiteColor),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
