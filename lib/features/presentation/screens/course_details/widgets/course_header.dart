import 'package:flutter/material.dart';

class CourseHeader extends StatelessWidget {
  const CourseHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(
          "https://img.freepik.com/free-vector/gradient-ui-ux-background_23-2149024129.jpg",
          width: 80,
          height: 60,
        ),
        const SizedBox(width: 16),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Complete UX/UI & App Design',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Learn how to design effective UI/UX for mobile and web apps.',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
