import 'dart:io';

import 'package:ElevatED/core/constants/enum.dart';
import 'package:ElevatED/features/data/models/course/course_category.dart';

class User {
  final int? id;
  final UserRoleEnum? userRole;
  final String? email;
  final String? token;
  final String? password;
  final String? fullName;
  final File? profileImageFile;
  final File? coverImageFile;
  final String? profileImageUrl;
  final String? coverImageUrl;
  final String? description;
  final DateTime? birthDate;
  final String? phoneNumber;
  final List<CourseCategory>? interests;
  final List<String>? personalLinks;
  final String? professionalTitle;

  User({
    this.profileImageFile,
    this.coverImageFile,
    this.id,
    this.profileImageUrl,
    this.userRole,
    this.token,
    this.coverImageUrl,
    this.description,
    this.fullName,
    this.phoneNumber,
    this.birthDate,
    this.email,
    this.password,
    this.interests,
    this.personalLinks,
    this.professionalTitle,
  });
}
