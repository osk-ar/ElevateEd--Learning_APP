import 'package:ElevatED/core/constants/app_colors.dart';
import 'package:ElevatED/config/themes/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoRow extends StatelessWidget {
  const InfoRow({super.key, required this.title, required this.value});
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: getSemiBoldStyle(fontSize: 16.sp, color: AppColors.whiteColor),
        ),
        Text(
          value,
          style: getMediumStyle(fontSize: 14.sp, color: AppColors.primaryColor),
        ),
      ],
    );
  }
}
