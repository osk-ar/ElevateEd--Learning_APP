// ignore_for_file: prefer_const_constructors

import 'package:e_learning_app_gp/config/themes/theme.dart';
import 'package:e_learning_app_gp/core/resources/app_styles.dart';
import 'package:e_learning_app_gp/features/presentation/home/screen/widgets/course_card.dart';
import 'package:e_learning_app_gp/features/presentation/home/screen/widgets/home_progress_snippet.dart';
import 'package:e_learning_app_gp/features/presentation/home/screen/widgets/minimized_stats_snippet.dart';
import 'package:e_learning_app_gp/features/presentation/home/screen/widgets/home_appbar.dart';
import 'package:e_learning_app_gp/features/presentation/common/layouts/default_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  final String name = "Anwar";

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      bottomPadding: 0,
      scrollable: true,
      child: Column(
        children: [
          SizedBox(height: 16.h),
          HomeAppbar(name: name),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              MinimizedStatsSnippet(
                title: "Enrollment",
                value: "4",
                valueExtention: "Courses",
                icon: CupertinoIcons.book,
                progressValue: 0.6,
              ),
              MinimizedStatsSnippet(
                title: "Learning Time",
                value: "23",
                valueExtention: "Hrs",
                icon: CupertinoIcons.clock,
                progressValue: 0.4,
              ),
            ],
          ),
          SizedBox(height: 16.h),
          HomeProgressSnippet(),
          SizedBox(height: 24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "My Courses",
                style: getBoldStyle(fontSize: 16, color: MyTheme.textColor),
              ),
              TextButton(
                child: Text(
                  "Show All",
                  style:
                      getMediumStyle(fontSize: 14, color: MyTheme.primaryColor),
                ),
                onPressed: () {
                  //TODO add navigation to all my courses here
                },
              ),
            ],
          ),
          SizedBox(height: 16.h),
          CourseCard(
            imageurl: "https://picsum.photos/200/300",
            author: "Tim Marshall",
            title: "Complete UX/UI & App Design",
            rating: "4.8",
            videoCount: "9/20",
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
