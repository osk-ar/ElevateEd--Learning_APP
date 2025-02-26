import 'dart:io';

import 'package:ElevatED/core/constants/enum.dart';

class User {
  final int? id;
  final UserRole? userRole;
  final String? email;
  final String? password;
  final String? fullName;
  final File? profileImageFile;
  final File? coverImageFile;
  final String? profileImageUrl;
  final String? coverImageUrl;
  final String? description;
  final DateTime? birthDate;
  final String? phoneNumber;
  final List<Interests>? interests;
  final List<String>? personalLinks;
  final String? professionalTitle;

  User({
    this.profileImageFile,
    this.coverImageFile,
    this.id,
    this.userRole,
    this.profileImageUrl,
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
