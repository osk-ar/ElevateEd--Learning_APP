import 'dart:io';

import 'package:e_learning_app_gp/core/constants/enum.dart';

class User {
  final String? id;
  final String? userRole;
  final Rank? rank;
  final String? token;
  final String? email;
  final String? password;
  final String? fullName;
  final String? profileImage;
  final String? coverImage;
  final File? profileImageFile;
  final File? coverImageFile;
  final String? description;
  final DateTime? birthDate;
  final String? phoneNumber;
  final int? firstPlaceCount;
  final int? thirdPlaceCount;
  final int? secondPlaceCount;
  final int? points;
  final DailyTask? dailyTask;

  User({
    this.profileImageFile,
    this.coverImageFile,
    this.id,
    this.userRole,
    this.coverImage,
    this.profileImage,
    this.points,
    this.firstPlaceCount,
    this.secondPlaceCount,
    this.thirdPlaceCount,
    this.description,
    this.fullName,
    this.phoneNumber,
    this.birthDate,
    this.token,
    this.rank,
    this.email,
    this.password,
    this.dailyTask,
  });
}

class DailyTask {
  final int? taskID;
  final String? userID;
  final String? taskName;
  final int? progress;
  final int? goal;
  final bool? isCompleted;

  final int? points;
  final DateTime? lastReset;

  DailyTask({
    this.taskID = 9999,
    this.userID = "Default User ID",
    this.taskName = "Default Name",
    this.progress = 0,
    this.goal = 1,
    this.isCompleted = false,
    this.points = 9999,
    DateTime? lastReset,
  }) : lastReset = lastReset ?? DateTime.now();
}
