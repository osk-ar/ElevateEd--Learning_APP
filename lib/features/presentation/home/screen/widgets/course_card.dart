import 'package:e_learning_app_gp/config/routes/route_constants.dart';
import 'package:e_learning_app_gp/config/themes/theme.dart';
import 'package:e_learning_app_gp/core/helper/extensions.dart';
import 'package:e_learning_app_gp/features/presentation/common/info_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseCard extends StatelessWidget {
  const CourseCard(
      {super.key,
      required this.imageurl,
      required this.author,
      required this.videoCount,
      required this.rating,
      required this.title});
  final String imageurl;
  final String title;
  final String author;
  final String videoCount;
  final String rating;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(Routes.courseDetailsScreenRoute);
      },
      child: Container(
        width: 358.w,
        height: 402.h,
        decoration: BoxDecoration(
          color: MyTheme.surfaceColor,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          children: [
            Container(
              width: 358.w,
              height: 201.h,
              decoration: BoxDecoration(
                color: MyTheme.onSurfaceColor,
                image: DecorationImage(
                  image: NetworkImage(imageurl),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(16).r,
                    topRight: const Radius.circular(16).r),
              ),
            ),
            SizedBox(height: 24.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  InfoRow(
                    title: "Title:",
                    value: title,
                  ),
                  SizedBox(height: 24.h),
                  InfoRow(
                    title: "Author:",
                    value: author,
                  ),
                  SizedBox(height: 24.h),
                  InfoRow(
                    title: "Video Count:",
                    value: videoCount,
                  ),
                  SizedBox(height: 24.h),
                  InfoRow(
                    title: "Rating:",
                    value: rating,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
/*
Container(
      width: 327.w,
      height: 368.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusConstants.medium.r,
        color: ThemeColors.surface,
      ),
      child: Column(
        children: [
          Container(
            width: 327.w,
            height: 184.h,
            decoration: BoxDecoration(
              color: ThemeColors.onSurface,
              image: DecorationImage(
                image: NetworkImage(widget.videoModel.thumbNailURL),
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16).r,
                  topRight: const Radius.circular(16).r),
            ),
          ),
          SizedBox(height: 24.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                InfoRow(
                  title: "Title:",
                  value: widget.videoModel.title,
                ),
                SizedBox(height: 24.h),
                InfoRow(
                  title: "Author:",
                  value: widget.videoModel.author,
                ),
                SizedBox(height: 24.h),
                InfoRow(
                  title: "Duration:",
                  value: widget.videoModel.duration.toString().split('.').first,
                ),
              ],
            ),
          )
        ],
      ),
    );
 */