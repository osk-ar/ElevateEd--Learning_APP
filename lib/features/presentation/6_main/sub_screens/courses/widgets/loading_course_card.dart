import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingCourseCard extends StatelessWidget {
  const LoadingCourseCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                color: ThemeColors.backgroundColor,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 24.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: ThemeColors.backgroundColor,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                SizedBox(height: 8.h),
                Container(
                  height: 16.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: ThemeColors.backgroundColor,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                SizedBox(height: 8.h),
                Container(
                  height: 16.h,
                  width: 200.w,
                  decoration: BoxDecoration(
                    color: ThemeColors.backgroundColor,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Container(
                      height: 16.h,
                      width: 80.w,
                      decoration: BoxDecoration(
                        color: ThemeColors.backgroundColor,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Container(
                      height: 16.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        color: ThemeColors.backgroundColor,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
