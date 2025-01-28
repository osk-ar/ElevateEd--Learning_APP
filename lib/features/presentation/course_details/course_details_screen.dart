import 'package:e_learning_app_gp/config/themes/theme.dart';
import 'package:e_learning_app_gp/core/helper/extensions.dart';
import 'package:e_learning_app_gp/core/resources/app_styles.dart';
import 'package:e_learning_app_gp/core/resources/text_styles.dart';
import 'package:e_learning_app_gp/features/presentation/common/layouts/default_layout.dart';
import 'package:e_learning_app_gp/features/presentation/course_details/widgets/course_header.dart';
import 'package:e_learning_app_gp/features/presentation/course_details/widgets/instructor_list_tile.dart';
import 'package:e_learning_app_gp/features/presentation/course_details/widgets/video_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: camel_case_types
class courseDetailsScreen extends StatefulWidget {
  const courseDetailsScreen({super.key});

  @override
  State<courseDetailsScreen> createState() => courseDetailsScreenState();
}

// ignore: camel_case_types
class courseDetailsScreenState extends State<courseDetailsScreen> {
  final List<Widget> videoTiles = [
    VideoListTile(
      title: '1. Introducing UI/UX Design',
      duration: '43:30',
      onTap: () {},
    ),
    VideoListTile(
      title: '2. Figma Fundamentals',
      duration: '22:40',
      onTap: () {},
    ),
    VideoListTile(
      title: '3. Designer Career Path',
      duration: '34:30',
      onTap: () {},
    ),
    VideoListTile(
      title: '4. Introducing UI/UX Design',
      duration: '43:30',
      onTap: () {},
    ),
    VideoListTile(
      title: '5. Figma Fundamentals',
      duration: '22:40',
      onTap: () {},
    ),
    VideoListTile(
      title: '6. Designer Career Path',
      duration: '34:30',
      onTap: () {},
    ),
    VideoListTile(
      title: '7. Introducing UI/UX Design',
      duration: '43:30',
      onTap: () {},
    ),
    VideoListTile(
      title: '8. Figma Fundamentals',
      duration: '22:40',
      onTap: () {},
    ),
    VideoListTile(
      title: '9. Designer Career Path',
      duration: '34:30',
      onTap: () {},
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.backgroundColor,
      appBar: _getCourseDetailsAppBar,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _getFAB,
      body: DefaultLayout(
        topPadding: 0,
        bottomPadding: 0,
        scrollable: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 16.h),
            const CourseHeader(
              imageurl: "https://picsum.photos/200/300",
              courseTitle: "Complete UX/UI & App Design",
              courseDescription:
                  "In today's digital age, having a strong online presence is essential for businesses and individuals alike With the increasing use of our daily lives With the increasing use of our daily lives",
            ),
            SizedBox(height: 16.h),
            InstructorListTile(
              imageUrl:
                  'https://img.freepik.com/free-photo/lovely-good-natured-afro-american-man-white-shirt-having-charming-smile-friendly-expression_273609-14102.jpg',
              instructorName: 'Tim Marshall',
              instructorProffesionalTitle: 'UI/UX Designer in Pixency',
              onPressed: () {
                //TODO navigate to instructor profile
              },
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 40.h,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyTheme.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      onPressed: () {
                        //TODO navigate to this course chat group
                      },
                      child: Text(
                        'Community',
                        style: getRegularStyle(
                            fontSize: 14.sp, color: MyTheme.textColor),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: SizedBox(
                    height: 40.h,
                    child: Center(
                      child: Text(
                        'Completed: 45%',
                        style: getRegularStyle(
                            fontSize: 14.sp, color: MyTheme.textColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Text(
              'Total Length: 11h 30m',
              style:
                  getSemiBoldStyle(fontSize: 20.sp, color: MyTheme.textColor),
            ),
            SizedBox(height: 8.h),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: videoTiles.length,
              itemBuilder: (context, index) {
                return videoTiles[index];
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 8.h);
              },
            ),
            SizedBox(height: 80.h),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget? get _getCourseDetailsAppBar {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      title: Text("Course Details",
          style: AppTextStyles.mediumTextStyle(context, fontSize: 24)),
      actions: [
        IconButton(
          //TODO add favourite functionality
          onPressed: () {},
          icon: const Icon(
            Icons.favorite_border_rounded,
            color: MyTheme.textColor,
          ),
        ),
      ],
    );
  }

  Widget? get _getFAB {
    return SizedBox(
      width: context.width - 32.w,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: MyTheme.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () {
          //Todo add navigation to last seen video / quiz
        },
        child: Text(
          'Continue Learning',
          style: getRegularStyle(fontSize: 16.sp, color: MyTheme.textColor),
        ),
      ),
    );
  }
}
