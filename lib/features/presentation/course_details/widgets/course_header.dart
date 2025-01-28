import 'package:e_learning_app_gp/core/resources/app_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_learning_app_gp/config/themes/theme.dart';
import 'package:flutter/material.dart';

class CourseHeader extends StatefulWidget {
  const CourseHeader(
      {super.key,
      required this.imageurl,
      required this.courseTitle,
      required this.courseDescription});
  final String imageurl;
  final String courseTitle;
  final String courseDescription;

  @override
  State<CourseHeader> createState() => _CourseHeaderState();
}

class _CourseHeaderState extends State<CourseHeader> {
  int maxLines = 3;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 80.w,
              height: 60.h,
              decoration: BoxDecoration(
                color: MyTheme.onSurfaceColor,
                image: DecorationImage(
                  image: NetworkImage(widget.imageurl),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                widget.courseTitle,
                style: getBoldStyle(fontSize: 20, color: MyTheme.textColor),
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                maxLines: 2,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Text(
          'About Course :',
          style: getBoldStyle(fontSize: 16.sp, color: MyTheme.textColor),
        ),
        InkWell(
          onTap: () {
            //TODO expand description text on click
            //! using setState for test purpose only, remove it later
            print("clicked $maxLines");
            setState(() {
              maxLines = maxLines == 3 ? 10 : 3;
            });
          },
          child: Text(
            maxLines: maxLines,
            softWrap: true,
            widget.courseDescription,
            overflow: TextOverflow.ellipsis,
            style: getLightStyle(fontSize: 14.sp, color: MyTheme.textColor),
          ),
        ),
      ],
    );
  }
}
