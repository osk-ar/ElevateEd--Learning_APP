import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:ElevatED/core/constants/app_strings.dart';
import 'package:ElevatED/core/constants/enum.dart';
import 'package:ElevatED/core/constants/app_colors.dart';
import 'package:ElevatED/config/themes/text_styles.dart';
import 'package:ElevatED/core/services/Language%20Service/language_service.dart';
import 'package:ElevatED/features/presentation/3_register/cubits/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RolePicker extends StatelessWidget {
  const RolePicker({
    super.key,
    this.width = 200,
    this.height = 45,
    this.radius = 25,
    this.animationDuration = 300,
    required this.isStudent,
  });

  final double width;
  final double height;
  final double radius;
  final int animationDuration;
  final bool isStudent;

  @override
  Widget build(BuildContext context) {
    final TextDirection direction = LanguageService.getTextDirection(context);
    final bool inverse = direction == TextDirection.rtl;
    const double left = 0;
    final double right = width.w / 2;
    final double position = inverse
        ? isStudent
            ? right
            : left
        : isStudent
            ? left
            : right;
    return Container(
      width: width.w,
      height: height.h,
      decoration: BoxDecoration(
        color: ThemeColors.secondaryColor,
        borderRadius: BorderRadius.circular(radius.r),
        border: Border.all(
            color: AppColors.primaryColor,
            strokeAlign: BorderSide.strokeAlignOutside),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          AnimatedPositioned(
            duration: Duration(milliseconds: animationDuration),
            curve: Curves.easeInOut,
            left: position,
            child: AnimatedContainer(
              duration: Duration(milliseconds: animationDuration),
              curve: Curves.easeInOut,
              width: width.w / 2,
              height: height.h,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(radius.r),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Center(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      overlayColor: Colors.transparent,
                      surfaceTintColor: Colors.transparent,
                    ),
                    onPressed: () {
                      context
                          .read<RegisterCubit>()
                          .toggleRole(UserRoleEnum.student);
                    },
                    child: Text(
                      AppStrings.student,
                      style: getMediumStyle(
                        fontSize: 16.sp,
                        color:
                            isStudent ? Colors.white : AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      overlayColor: Colors.transparent,
                      surfaceTintColor: Colors.transparent,
                    ),
                    onPressed: () {
                      context
                          .read<RegisterCubit>()
                          .toggleRole(UserRoleEnum.instructor);
                    },
                    child: Text(
                      AppStrings.instructor,
                      style: getMediumStyle(
                        fontSize: 16.sp,
                        color:
                            isStudent ? AppColors.primaryColor : Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
