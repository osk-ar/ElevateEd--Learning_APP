import 'package:ElevatED/features/data/models/assignment/assignment.dart';
import 'package:ElevatED/features/data/models/course/course_category.dart';
import 'package:ElevatED/features/data/models/view/normalized_course_content.dart';

class UploadCourseModel {
  final int instructorID;
  final double price;
  CourseCategory category;
  String courseTitle;
  String courseDescription;
  List<Assignment> assignments;
  List<UploadCourseVideo> videos;

  // Normal constructor
  UploadCourseModel({
    required this.instructorID,
    required this.price,
    required this.category,
    this.courseTitle = "",
    this.courseDescription = "",
    this.assignments = const [],
    this.videos = const [],
  });

  // fromJson constructor
  factory UploadCourseModel.fromJson(Map<String, dynamic> json) {
    return UploadCourseModel(
      instructorID: json['instructorID'],
      price: json['price'],
      category: CourseCategory.fromJson(json['category']),
      courseTitle: json['title'],
      courseDescription: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'courseName': courseTitle,
      'description': courseDescription,
      'instructorId': instructorID,
      'categoryId': category.id,
      'price': price,
    };
  }
}
