import 'package:e_learning_app_gp/features/presentation/screens/course_details/widgets/course_header.dart';
import 'package:e_learning_app_gp/features/presentation/screens/course_details/widgets/lesson_tile.dart';
import 'package:e_learning_app_gp/features/presentation/screens/course_details/widgets/progress_bar.dart';
import 'package:e_learning_app_gp/features/presentation/screens/course_details/widgets/instructor_info.dart';
import 'package:flutter/material.dart';

class CourseDetailsScreen extends StatelessWidget {
  const CourseDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Details'),
        centerTitle: true,
        actions: const [
          Icon(Icons.bookmark),
          SizedBox(width: 16),
          Icon(Icons.menu),
          SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CourseHeader(),
            const SizedBox(height: 16),
            const InstructorInfo(),
            const SizedBox(height: 16),
            const ProgressBar(),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: const [
                  LessonTile(
                    title: '1. Introducing UI/UX Design',
                    duration: '43:30',
                  ),
                  LessonTile(
                    title: '2. Figma Fundamentals',
                    duration: '22:40',
                  ),
                  LessonTile(
                    title: '3. Designer Career Path',
                    duration: '34:30',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Continue Learning'),
            ),
          ],
        ),
      ),
    );
  }
}
