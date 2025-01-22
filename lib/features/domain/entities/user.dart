import 'dart:io';

import 'package:e_learning_app_gp/core/constants/enum.dart';

class User {
  final int? id;
  final UserRole? userRole;
  final String? email;
  final String? password;
  final String? fullName;
  final File? profileImageFile;
  final String? profileImage;
  final String? description;
  final DateTime? birthDate;
  final String? phoneNumber;
  final List<Interests>? interests;
  final List<String>? personalLinks;
  final String? professionalTitle;

  User({
    this.profileImageFile,
    this.id,
    this.userRole,
    this.profileImage,
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
