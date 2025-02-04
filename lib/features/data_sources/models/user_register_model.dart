import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:e_learning_app_gp/core/constants/enum.dart';

class UserRegisterModel {
  final String? fullName;
  final String? email;
  final String? password;
  final UserRole? userRole;
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

  FormData toJson() {
    return FormData.fromMap({
      'fullName': fullName,
      'email': email,
      'password': password,
      'role': userRole,
      'phoneNumber': phoneNumber,
      'profilePicture': profileImage,
      'dateOfBirth': birthDate?.toIso8601String(),
      'description': description,
      'expertsInterests': interests,
      //*-
      'personalLinks': personalLinks,
      'professionalTitle': professionalTitle,
    });
  }

  Future<FormData> toJsonWithFiles() async {
    late MultipartFile? profilePic;
    if (profileImage == null) {
      profilePic = null;
    } else {
      log(profileImage!.path);
      profilePic = await MultipartFile.fromFile(profileImage!.path);
    }
    log(fullName!);
    log(email!);
    log(password!);
    log(userRole!.name);
    log(phoneNumber!);
    log(birthDate!.toString().split(" ")[0]);
    log(description!);
    log(interests.toString());
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



/*

var data = FormData.fromMap({
  'files': [
    await MultipartFile.fromFile('/C:/Users/Pro Remo/OneDrive/Pictures/Screenshots/Screenshot 2024-07-06 155106.png', filename: '/C:/Users/Pro Remo/OneDrive/Pictures/Screenshots/Screenshot 2024-07-06 155106.png')
  ],
  'fullName': 'remon',
  'email': 'remo8792@example.com',
  'password': 'pass1111',
  'role': 'STUDENT',
  'phoneNumber': '201234567890',
  'dateOfBirth': '2000-01-01',
  'description': 'طالب في علوم الحاسب',
  'expertsInterests': 'program,graphic'
});

var dio = Dio();
var response = await dio.request(
  'http://localhost:8080/api/auth/register',
  options: Options(
    method: 'POST',
  ),
  data: data,
);

if (response.statusCode == 200) {
  print(json.encode(response.data));
}
else {
  print(response.statusMessage);
}


 */