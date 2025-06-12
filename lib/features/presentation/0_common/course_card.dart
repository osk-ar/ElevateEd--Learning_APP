import 'package:ElevatED/config/extensions.dart';
import 'package:ElevatED/config/routes/route_constants.dart';
import 'package:ElevatED/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:ElevatED/features/data/models/view/normalized_course.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:ElevatED/config/themes/text_styles.dart';

class CourseCard extends StatelessWidget {
  final NormalizedCourse course;

  const CourseCard({
    super.key,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: InkWell(
        onTap: () {
          context.pushNamed(
            RouteConstants.courseDetailsScreenRoute,
            arguments: course.id,
          );
        },
        borderRadius: BorderRadius.circular(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Course Image
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(16.r)),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Container(
                      color: ThemeColors.secondaryColor,
                      child: Center(
                        child: Icon(
                          Icons.school,
                          size: 48.w,
                          color: ThemeColors.inverseTextColor,
                        ),
                      ),
                    ),
                  ),
                ),
                // Category Badge
                Positioned(
                  top: 12.h,
                  left: 12.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: ThemeColors.backgroundColor.withAlpha(200),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      course.category.name,
                      style: getMediumStyle(
                        fontSize: 12.sp,
                        color: ThemeColors.textColor,
                      ),
                    ),
                  ),
                ),
                // Price Badge
                Positioned(
                  top: 12.h,
                  right: 12.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.inversePrimaryColor,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      '\$${course.price.toStringAsFixed(2)}',
                      style: getMediumStyle(
                        fontSize: 14.sp,
                        color: ThemeColors.inverseTextColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Course Content
            Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    course.title,
                    style: getBoldStyle(
                      fontSize: 18.sp,
                      color: ThemeColors.textColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8.h),
                  // Description
                  Text(
                    course.description,
                    style: getRegularStyle(
                      fontSize: 14.sp,
                      color: ThemeColors.subTextColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 16.h),
                  // Instructor and Rating Row
                  Row(
                    children: [
                      // Instructor
                      Expanded(
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 16.r,
                              backgroundColor: ThemeColors.secondaryColor,
                              child: Text(
                                course.instructorName[0].toUpperCase(),
                                style: getMediumStyle(
                                  fontSize: 14.sp,
                                  color: ThemeColors.textColor,
                                ),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Text(
                                course.instructorName,
                                style: getMediumStyle(
                                  fontSize: 14.sp,
                                  color: ThemeColors.textColor,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Rating
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: ThemeColors.secondaryColor,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.star,
                              size: 16.w,
                              color: Colors.amber,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              course.rating.toStringAsFixed(1),
                              style: getMediumStyle(
                                fontSize: 14.sp,
                                color: ThemeColors.textColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
