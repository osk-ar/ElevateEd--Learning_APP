import 'dart:developer';

import 'package:ElevatED/features/data/models/assignment/assignment.dart';
import 'package:ElevatED/features/data/models/course/course_category.dart';
import 'package:ElevatED/features/data/models/video/video.dart';

class Course {
  final int id;
  final CourseCategory category;
  final String title;
  final String description;
  final String instructorName;
  final int instructorId;
  final double rating;
  final double price;
  final List<Video> videos;
  final List<Assignment> assignments;
  final bool isOwned;

  // Normal constructor
  Course({
    required this.id,
    required this.category,
    required this.title,
    required this.description,
    required this.instructorName,
    required this.instructorId,
    required this.rating,
    required this.price,
    required this.videos,
    required this.assignments,
    required this.isOwned,
  });

  // fromJson constructor
  factory Course.fromJson(Map<String, dynamic> json) {
    final courseDetails = json["courseDetails"];
    log(courseDetails['tasks'].toString());
    return Course(
      id: courseDetails['id'],
      title: courseDetails['courseName'],
      category: CourseCategory.fromJson(courseDetails['category']),
      description: courseDetails['description'],
      rating: (courseDetails['rating'] as num).toDouble(),
      price: (courseDetails['price'] as num).toDouble(),
      instructorId: courseDetails['author']["id"],
      instructorName: courseDetails['author']["fullName"],
      videos: (courseDetails['videos'] as List<dynamic>)
          .map((video) => Video.fromJson(video))
          .toList()
        ..sort((a, b) => a.index.compareTo(b.index)),
      assignments: (courseDetails['tasks'] as List<dynamic>)
          .map((assignment) =>
              Assignment.fromJson(assignment as Map<String, dynamic>))
          .toList()
        ..sort((a, b) => a.index.compareTo(b.index)),
      isOwned: json["isOwned"],
    );
  }
}
