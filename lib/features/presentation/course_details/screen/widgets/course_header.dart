import 'package:ElevatED/core/resources/app_styles.dart';
import 'package:ElevatED/features/presentation/course_details/cubits/course_details_cubit.dart';
import 'package:ElevatED/features/presentation/course_details/states/course_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ElevatED/config/themes/theme.dart';
import 'package:flutter/material.dart';

class CourseHeader extends StatelessWidget {
  const CourseHeader(
      {super.key,
      required this.imageurl,
      required this.courseTitle,
      required this.courseDescription});
  final String imageurl;
  final String courseTitle;
  final String courseDescription;

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
                  image: NetworkImage(imageurl),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                courseTitle,
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
            context.read<CourseDetailsCubit>().changeDescriptionSize();
          },
          child: BlocBuilder<CourseDetailsCubit, CourseDetailsState>(
            buildWhen: (previous, current) {
              return current is CourseDetailsDescriptionSizeChanged;
            },
            builder: (context, state) {
              late int maxLines;
              if (state is CourseDetailsDescriptionSizeChanged) {
                maxLines = state.size;
              } else {
                maxLines = 3;
              }
              print("rebuilding!");

              return Text(
                maxLines: maxLines,
                softWrap: true,
                courseDescription,
                overflow: TextOverflow.ellipsis,
                style: getLightStyle(fontSize: 14.sp, color: MyTheme.textColor),
              );
            },
          ),
        ),
      ],
    );
  }
}
