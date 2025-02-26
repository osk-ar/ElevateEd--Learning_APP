import 'package:ElevatED/config/themes/theme.dart';
import 'package:ElevatED/core/constants/enum.dart';
import 'package:ElevatED/core/resources/app_colors.dart';
import 'package:ElevatED/core/resources/app_styles.dart';
import 'package:ElevatED/features/presentation/register/cubits/register_cubit.dart';
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
            left: isStudent ? 0 : width.w / 2,
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
                          .toggleRole(UserRole.student);
                    },
                    child: Text(
                      'Student',
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
                          .toggleRole(UserRole.instructor);
                    },
                    child: Text(
                      'Instructor',
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
