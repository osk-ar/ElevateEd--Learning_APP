import 'package:ElevatED/core/constants/enum.dart';
import 'package:dio/dio.dart';
import 'dart:io';

class UserRegisterModel {
  final String? fullName;
  final String? email;
  final String? password;
  final UserRoleEnum? userRole;
  final String? phoneNumber;
  final File? profileImage;
  final DateTime? birthDate;
  final String? description;
  final List<String>? interests;
  //*-
  final String? professionalTitle;
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

  Future<FormData> toJson() async {
    late MultipartFile? profilePic;

    if (profileImage == null) {
      profilePic = null;
    } else {
      profilePic = await MultipartFile.fromFile(profileImage!.path);
    }

    return FormData.fromMap({
      'profilePicture': profilePic,
      'fullName': fullName,
      'email': email,
      'password': password,
      'role': userRole!.name,
      'phoneNumber': phoneNumber,
      'dateOfBirth': birthDate!.toString().split(" ")[0],
      'description': description,
      'expertsInterests': interests,
      //*-
      'personalLinks': personalLinks,
      'professionalTitle': professionalTitle,
    });
  }
}
