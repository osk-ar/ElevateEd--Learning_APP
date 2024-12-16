import 'dart:io';

import 'package:e_learning_app_gp/core/constants/enum.dart';

class User {
  final int? id;
  final UserRole? userRole;
  final String? email;
  final String? password;
  final String? fullName;
  final String? profileImage;
  final File? profileImageFile;
  final String? description;
  final DateTime? birthDate;
  final String? phoneNumber;

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
  });
}
