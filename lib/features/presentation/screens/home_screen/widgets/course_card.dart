import 'package:flutter/material.dart';
class CourseCard extends StatelessWidget {
  const CourseCard({super.key, required this.imageUrl, required this.title});
final String  imageUrl, title;


  @override

  
Widget build (BuildContext context, ) {
  return Column(
    children: [
      Container(
        width: 100,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
      const SizedBox(height: 8),
      Text(title),
    ],
  );
}

}