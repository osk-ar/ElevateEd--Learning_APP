import 'dart:io';

import 'package:dio/dio.dart';
import 'package:e_learning_app_gp/core/constants/enum.dart';

class UserRegisterModel {
  final UserRole? userRole;
  final String? fullName;
  final String? email;
  final String? password;
  final String? phoneNumber;
  final DateTime? birthDate;
  final File? profileImage;
  final String? professionalTitle;
  final String? description;
  final List<Interests>? interests;
  final List<String>? personalLinks;

  UserRegisterModel({
    this.profileImage,
    this.professionalTitle,
    this.description,
    this.interests,
    this.personalLinks,
    this.userRole,
    this.fullName,
    this.phoneNumber,
    this.birthDate,
    this.email,
    this.password,
  });

  FormData toJson() {
    return FormData.fromMap({
      'userRole': userRole,
      'firstName': fullName,
      'phoneNumber': phoneNumber,
      'birthDate': birthDate?.toIso8601String(),
      'email': email,
      'password': password,
      'profileImage': profileImage,
      'professionalTitle': professionalTitle,
      'description': description,
      'interests': interests,
      'personalLinks': personalLinks,
    });
  }
}
