import 'package:ElevatED/config/themes/text_styles.dart';
import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:ElevatED/core/constants/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class CourseItemListTile extends StatelessWidget {
  const CourseItemListTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });
  final void Function() onTap;
  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
      tileColor: ThemeColors.secondaryColor,
      leading: CircleAvatar(
        backgroundColor: AppColors.primaryColor,
        child: Icon(icon, color: AppColors.whiteColor, size: 24.r),
      ),
      title: Text(
        title,
        style: getLightStyle(fontSize: 14.sp, color: ThemeColors.textColor),
      ),
    );
  }
}


/*
Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: MyTheme.primaryColor,
            ),
            child: const Center(
              child: Icon(Icons.play_arrow),
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
              ),
              const SizedBox(height: 4),
              Text(
                duration,
              ),
            ],
          ),
        ],
      ),
    );
 */