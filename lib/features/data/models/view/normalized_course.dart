import 'package:ElevatED/core/constants/enum.dart';
import 'package:ElevatED/features/data/models/course/course_category.dart';

class NormalizedCourse {
  int id;
  CourseCategory category;
  String title;
  String description;
  String instructorName;
  int instructorId;
  double rating;
  double price;
  CourseStatusEnum status;

  // Normal constructor
  NormalizedCourse({
    required this.id,
    required this.category,
    required this.title,
    required this.description,
    required this.instructorName,
    required this.instructorId,
    required this.rating,
    required this.price,
    this.status = CourseStatusEnum.uploaded,
  });

  // fromJson constructor
  factory NormalizedCourse.fromJson(Map<String, dynamic> json) {
    return NormalizedCourse(
      id: json['id'],
      title: json['name'],
      description: json['description'],
      rating: (json['rating'] as num).toDouble(),
      instructorId: json['author']["id"],
      instructorName: json['author']["fullName"],
      category: CourseCategory.fromJson(json['category']),
      price: json['price'],
      status: CourseStatusEnum.uploaded,
    );
  }
}
