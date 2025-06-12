import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:ElevatED/config/themes/text_styles.dart';
import 'package:ElevatED/core/constants/app_colors.dart';
import 'package:ElevatED/core/constants/app_strings.dart';
import 'package:ElevatED/core/constants/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({super.key, required this.name, required this.role});
  final String name;
  final UserRoleEnum role;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: AppStrings.hello,
                style: getMediumStyle(
                    fontSize: 16.sp, color: ThemeColors.textColor),
              ),
              TextSpan(
                text: "$name\n",
                style: getMediumStyle(
                    fontSize: 16.sp, color: AppColors.primaryColor),
              ),
              TextSpan(
                text: role == UserRoleEnum.student
                    ? AppStrings.letsLearnNow
                    : "Let's improve your income!",
                style: getSemiBoldStyle(
                        fontSize: 22.sp, color: ThemeColors.textColor)
                    .copyWith(height: 1.5.sp),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_outlined),
          style:
              IconButton.styleFrom(backgroundColor: ThemeColors.secondaryColor),
        ),
      ],
    );
  }
}
