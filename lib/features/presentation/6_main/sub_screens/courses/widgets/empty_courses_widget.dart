import 'package:flutter/material.dart';
import 'package:ElevatED/core/constants/app_strings.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyCoursesWidget extends StatelessWidget {
  final bool isPurchasedTab;

  const EmptyCoursesWidget({
    super.key,
    required this.isPurchasedTab,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.school_outlined,
              size: 64.w,
              color: Colors.grey[400],
            ),
            SizedBox(height: 16.h),
            Text(
              isPurchasedTab
                  ? AppStrings.noPurchasedCourses
                  : AppStrings.noCoursesFound,
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.grey[800],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
