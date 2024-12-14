import 'package:flutter/material.dart';

class InstructorInfo extends StatelessWidget {
  const InstructorInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(
            'https://img.freepik.com/free-photo/lovely-good-natured-afro-american-man-white-shirt-having-charming-smile-friendly-expression_273609-14102.jpg',
          ),
        ),
        SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tim Marshall',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              'UI/UX Designer in Pixency',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        Spacer(),
        Text(
          '5 Courses',
          style: TextStyle(color: Colors.blue, fontSize: 14),
        ),
        Icon(Icons.arrow_forward),
      ],
    );
  }
}
