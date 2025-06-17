import 'package:ElevatED/core/constants/enum.dart';
import 'package:ElevatED/features/data/mappers/user_role_mapper.dart';
import 'package:ElevatED/features/data/models/course/course_category.dart';
import 'package:ElevatED/features/data/models/data_point.dart';
import 'package:ElevatED/features/data/models/view/normalized_course.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class UserData {
  int id;
  String token;
  UserRoleEnum role;
  String name;
  String description;
  DateTime dateOfBirth;
  String email;
  String phone;
  String profilePictureUrl;
  List<NormalizedCourse> purchasedCourses;

  UserData(
      {required this.id,
      required this.name,
      required this.email,
      required this.phone,
      required this.token,
      required this.profilePictureUrl,
      required this.role,
      required this.description,
      required this.purchasedCourses,
      required this.dateOfBirth});

  static String getProfilePictureUrl(String url) {
    String imgName = url.split("/").last;

    return "${dotenv.get('API_LINK')}auth/files/$imgName";
  }
}

class StudentUserData extends UserData {
  List<DataPoint> activityPoints;
  List<CourseCategory> interests;

  StudentUserData({
    required super.id,
    required super.name,
    required super.email,
    required super.phone,
    required super.token,
    required super.profilePictureUrl,
    required super.role,
    required super.description,
    required super.dateOfBirth,
    required this.interests,
    required this.activityPoints,
    required super.purchasedCourses,
  });

  factory StudentUserData.fromJson(Map<String, dynamic> json) {
    return StudentUserData(
      token: json['token'] ?? "",
      id: json['id'],
      name: json['fullName'],
      email: json['email'],
      phone: json['phoneNumber'],
      profilePictureUrl:
          UserData.getProfilePictureUrl(json['profilePictureUrl']),
      role: UserRoleMapper.stringToEnum((json['role'] as String)),
      description: json['description'],
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      interests: json['expertsInterests'] != null
          ? (json['expertsInterests'] as List)
              .cast<Map<String, dynamic>>()
              .map((cat) => CourseCategory.fromJson(cat))
              .toList()
          : [],
      purchasedCourses: json['purchased_courses'] != null
          ? (json['purchased_courses'] as List)
              .cast<Map<String, dynamic>>()
              .map((course) => NormalizedCourse.fromJson(course))
              .toList()
          : [],
      activityPoints: [],

      /*
      
      json['activityPoints'] != null
          ? (json['activityPoints'] as List)
          .cast<Map<String, dynamic>>()
          .map((point) => DataPoint.fromJson(point))
          .toList()
          : 
      
       */
    );
  }
}

class InstructorUserData extends UserData {
  int totalStudents;
  List<NormalizedCourse> createdCourses;
  List<DataPoint> revenuePoints;
  List<String> personalLinks;
  String professionalTitle;
  List<CourseCategory> expertise;

  InstructorUserData({
    required super.id,
    required super.name,
    required super.email,
    required super.phone,
    required super.token,
    required super.profilePictureUrl,
    required super.role,
    required super.description,
    required super.dateOfBirth,
    required super.purchasedCourses,
    required this.expertise,
    required this.createdCourses,
    required this.totalStudents,
    required this.personalLinks,
    required this.professionalTitle,
    required this.revenuePoints,
  });

  factory InstructorUserData.fromJson(Map<String, dynamic> json) {
    return InstructorUserData(
      token: json['token'] ?? "",
      id: json['id'],
      name: json['fullName'],
      email: json['email'],
      phone: json['phoneNumber'],
      profilePictureUrl:
          UserData.getProfilePictureUrl(json['profilePictureUrl']),
      role: UserRoleMapper.stringToEnum(json['role']),
      description: json['description'],
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      expertise: (json['expertsInterests'] as List)
          .cast<Map<String, dynamic>>()
          .map((cat) => CourseCategory.fromJson(cat))
          .toList(),
      personalLinks: List<String>.from(json['personalLinks']),
      professionalTitle: json['professionalTitle'],
      createdCourses: (json['created_courses'] as List)
          .cast<Map<String, dynamic>>()
          .map((course) => NormalizedCourse.fromJson(course))
          .toList(),
      purchasedCourses: (json['purchased_courses'] as List)
          .cast<Map<String, dynamic>>()
          .map((course) => NormalizedCourse.fromJson(course))
          .toList(),
      totalStudents: json['totalStudents'],
      revenuePoints: [],

      /*
      
      json['revenuePoints'] != null
          ? (json['revenuePoints'] as List)
              .cast<Map<String, dynamic>>()
              .map((point) => DataPoint.fromJson(point))
              .toList()
          : 
      
      
       */
    );
  }
}
