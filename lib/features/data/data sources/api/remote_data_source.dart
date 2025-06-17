import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:ElevatED/core/constants/api_constants.dart';
import 'package:ElevatED/core/constants/app_keys.dart';
import 'package:ElevatED/core/constants/enum.dart';
import 'package:ElevatED/core/managers/error_manager.dart';
import 'package:ElevatED/core/services/Shared%20Preferences%20Service/shared_preferences_service.dart';
import 'package:ElevatED/features/data/data%20sources/cache/memory_cache.dart';
import 'package:ElevatED/features/data/mappers/user_role_mapper.dart';
import 'package:ElevatED/features/data/models/assignment/assignment.dart';
import 'package:ElevatED/features/data/models/course/course_category.dart';
import 'package:ElevatED/features/data/models/upload/upload_course_model.dart';
import 'package:ElevatED/features/data/models/video/comment.dart';
import 'package:ElevatED/features/data/models/video/stream/stream_response.dart';
import 'package:ElevatED/features/data/models/video/stream/stream_video_metadata.dart';
import 'package:ElevatED/features/data/models/video/upload_video_initialize.dart';
import 'package:ElevatED/features/data/models/video/video_chunk_model.dart';
import 'package:ElevatED/features/data/models/user_data.dart';
import 'package:ElevatED/features/data/models/user_login_model.dart';
import 'package:ElevatED/features/data/models/user_register_model.dart';
import 'package:ElevatED/features/data/models/course/course.dart';
import 'package:ElevatED/features/data/models/view/normalized_course.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class RemoteDataSource {
  late Dio dio;
  final SharedPreferencesService appSharedPrefs;
  RemoteDataSource(this.dio, this.appSharedPrefs);

  //*--------------------
  //? login by email and password
  //*--------------------
  Future<UserData> loginUser(UserLoginModel user) async {
    final response = await dio.request(
      '${dotenv.get('API_LINK')}auth/login',
      data: user.toJson(),
      options: Options(
        method: 'POST',
        headers: {'Content-Type': 'application/json'},
      ),
    );

    if (response.statusCode == 200) {
      final UserRoleEnum role =
          UserRoleMapper.stringToEnum(response.data["role"]);

      late final UserData userData;
      switch (role) {
        case UserRoleEnum.student:
          userData = StudentUserData.fromJson(response.data);
          break;
        case UserRoleEnum.instructor:
          userData = InstructorUserData.fromJson(response.data);
          break;
      }
      MemoryCache.pushUserData(userData);

      appSharedPrefs.setString(AppKeys.tokenKey, userData.token);
      appSharedPrefs.setInt(AppKeys.idKey, userData.id);
      return userData;
    }

    throw UserFriendlyException(
        ErrorManager.getAPIErrorMessage(response.statusCode));
  }

  //*--------------------
  //? register by email and password
  //*--------------------
  Future<UserData> registerUser(UserRegisterModel user) async {
    final response = await dio.request(
      '${dotenv.get(AppKeys.envApiLinkKey)}auth/register',
      data: await user.toJson(),
      options: Options(
        method: 'POST',
        headers: {'Content-Type': 'application/json'},
      ),
    );

    if (response.statusCode == 200) {
      final UserRoleEnum role =
          UserRoleMapper.stringToEnum(response.data["role"]);

      late final UserData userData;
      switch (role) {
        case UserRoleEnum.student:
          userData = StudentUserData.fromJson(response.data);
          break;
        case UserRoleEnum.instructor:
          userData = InstructorUserData.fromJson(response.data);
          break;
      }
      MemoryCache.pushUserData(userData);
      appSharedPrefs.setString(AppKeys.tokenKey, userData.token);
      appSharedPrefs.setInt(AppKeys.idKey, userData.id);
      return userData;
    }

    throw UserFriendlyException(
        ErrorManager.getAPIErrorMessage(response.statusCode));
  }

  //*--------------------
  //? get user profile by id
  //*--------------------
  Future<UserData> getUserProfile(int userId) async {
    final response = await dio.request(
      '${dotenv.get(AppKeys.envApiLinkKey)}auth/$userId',
      options: Options(
        method: 'GET',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${MemoryCache.getUserData()!.token}',
        },
      ),
    );

    if (response.statusCode == 200) {
      final UserRoleEnum role =
          UserRoleMapper.stringToEnum(response.data["role"]);

      late final UserData userData;
      switch (role) {
        case UserRoleEnum.student:
          userData = StudentUserData.fromJson(response.data);
          break;
        case UserRoleEnum.instructor:
          userData = InstructorUserData.fromJson(response.data);
          break;
      }
      return userData;
    }

    throw UserFriendlyException(
        ErrorManager.getAPIErrorMessage(response.statusCode));
  }

  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///

  //*--------------------
  //? send otp to user email
  //*--------------------
  Future<bool> sendOtp(String email) async {
    final data = json.encode({"email": email});

    final response = await dio.request(
      "${dotenv.get(AppKeys.envApiLinkKey)}auth/forgot-password",
      options: Options(
        method: 'POST',
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      return true;
    }

    throw UserFriendlyException(
        ErrorManager.getAPIErrorMessage(response.statusCode));
  }

  //*--------------------
  //? verify otp
  //*--------------------
  Future<bool> verifyOtp(String email, String otp) async {
    final String parameters = "?email=$email&otp=$otp";

    final response = await dio.request(
      "${dotenv.get(AppKeys.envApiLinkKey)}auth/verify-otp$parameters",
      options: Options(
        method: 'POST',
      ),
    );

    if (response.statusCode == 200) {
      return response.data;
    }

    throw UserFriendlyException(
        ErrorManager.getAPIErrorMessage(response.statusCode));
  }

  //*--------------------
  //? reset password
  //*--------------------
  Future<bool> resetPassword(String email, String password) async {
    final String parameters = "?email=$email&newPassword=$password";

    final response = await dio.request(
      "${dotenv.get(AppKeys.envApiLinkKey)}auth/reset-password$parameters",
      options: Options(
        method: 'POST',
      ),
    );

    if (response.statusCode == 200) {
      return response.data;
    }

    throw UserFriendlyException(
        ErrorManager.getAPIErrorMessage(response.statusCode));
  }

  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  //*--------------------
  //? get all categories
  //*--------------------
  Future<List<CourseCategory>> getCategories() async {
    List<CourseCategory> cats = MemoryCache.getCategories();
    if (cats.isNotEmpty) {
      return cats;
    }

    final response = await dio.request(
      '${dotenv.get(AppKeys.envApiLinkKey)}categories/all',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      cats = (response.data as List<dynamic>)
          .map((catJson) => CourseCategory.fromJson(catJson))
          .toList();

      MemoryCache.pushCategories(cats);
      return cats;
    }

    throw UserFriendlyException(
        ErrorManager.getAPIErrorMessage(response.statusCode));
  }

  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  //*--------------------
  //? get all courses with pagination, filters, and order
  //*--------------------
  Future<List<NormalizedCourse>> getAllCourses({
    required int page,
    required int pageSize,
  }) async {
    final response = await dio.request(
      '${dotenv.get(AppKeys.envApiLinkKey)}courses',
      options: Options(
        method: 'GET',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${MemoryCache.getUserData()!.token}',
        },
      ),
    );

    if (response.statusCode == 200) {
      return (response.data as List<dynamic>)
          .map((courseJson) => NormalizedCourse.fromJson(courseJson))
          .toList();
    }

    throw UserFriendlyException(
        ErrorManager.getAPIErrorMessage(response.statusCode));
  }

  //*--------------------
  //? get course by id
  //*--------------------
  Future<Course> getCourseByID({
    required int userId,
    required int courseId,
  }) async {
    final response = await dio.request(
      '${dotenv.get(AppKeys.envApiLinkKey)}courses/owned',
      options: Options(
        method: 'GET',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${MemoryCache.getUserData()!.token}',
        },
      ),
      queryParameters: {
        'studentId': userId,
        'courseId': courseId,
      },
    );

    if (response.statusCode == 200) {
      return Course.fromJson(response.data);
    }

    throw UserFriendlyException(
        ErrorManager.getAPIErrorMessage(response.statusCode));
  }

  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  //*--------------------
  //? buy course
  //*--------------------
  Future<String> buyCourse({
    required int userId,
    required int courseId,
  }) async {
    final response = await dio.request(
      '${dotenv.get(AppKeys.envApiLinkKey)}payment/create',
      options: Options(
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${MemoryCache.getUserData()!.token}',
        },
      ),
      queryParameters: {
        'userId': userId,
        'courseId': courseId,
      },
    );

    if (response.statusCode == 200) {
      return response.data["url"];
    }

    throw UserFriendlyException(
        ErrorManager.getAPIErrorMessage(response.statusCode));
  }

  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  //*--------------------
  //? upload course
  //*--------------------
  Future<int> uploadCourseDetails(UploadCourseModel course) async {
    final response = await dio.request(
      '${dotenv.get(AppKeys.envApiLinkKey)}courses/add',
      options: Options(
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${MemoryCache.getUserData()!.token}',
        },
      ),
      data: course.toJson(),
    );

    if (response.statusCode == 200) {
      log("200 from upload course details");
      return response.data;
    }

    throw UserFriendlyException(
        ErrorManager.getAPIErrorMessage(response.statusCode));
  }

  //*--------------------
  //? upload course assignment
  //*--------------------
  Future<void> uploadCourseAssignment(
      Assignment assignment, int courseID) async {
    final response = await dio.request(
      '${dotenv.get(AppKeys.envApiLinkKey)}quizzes/course/$courseID',
      options: Options(
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${MemoryCache.getUserData()!.token}',
        },
      ),
      data: assignment.toJson(),
    );

    if (response.statusCode == 200) {
      log("200 from upload assignments");
      return;
    }

    throw UserFriendlyException(
        ErrorManager.getAPIErrorMessage(response.statusCode));
  }

  //*--------------------
  //? upload video
  //*--------------------
  Future<String> uploadVideoInitialize(
      UploadVideoInitializeModel videoModel) async {
    final response = await dio.request(
      '${dotenv.get(AppKeys.envApiLinkKey)}upload/initialize',
      options: Options(
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${MemoryCache.getUserData()!.token}',
        },
      ),
      data: videoModel.toJson(),
    );

    if (response.statusCode == 200) {
      log("200 from upload initialzie");
      return response.data["uploadId"];
    }

    throw UserFriendlyException(
        ErrorManager.getAPIErrorMessage(response.statusCode));
  }

  Future<void> uploadVideoChunk(VideoChunkModel chunk) async {
    var data = FormData.fromMap({
      'file': [
        await MultipartFile.fromFile(chunk.file.path,
            filename: chunk.file.path.split("/").last)
      ],
      'uploadId': chunk.uploadID,
      'chunkIndex': chunk.chunkIndex.toString()
    });

    final response = await dio.request(
      '${dotenv.get(AppKeys.envApiLinkKey)}upload/chunk',
      options: Options(
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${MemoryCache.getUserData()!.token}',
        },
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      log("200 from upload chunk: ${chunk.chunkIndex}");
      return;
    }

    throw UserFriendlyException(
        ErrorManager.getAPIErrorMessage(response.statusCode));
  }

  Future<void> uploadVideoFinalize(String uploadID) async {
    final response =
        await dio.request('${dotenv.get(AppKeys.envApiLinkKey)}upload/finalize',
            options: Options(
              method: 'POST',
              headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer ${MemoryCache.getUserData()!.token}',
              },
            ),
            data: {"uploadId": uploadID});

    if (response.statusCode == 200) {
      log("200 from upload finalize");
      return;
    }

    throw UserFriendlyException(
        ErrorManager.getAPIErrorMessage(response.statusCode));
  }

  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  //*--------------------
  //? stream video
  //*--------------------

  Future<StreamResponse> streamVideoChunk(
      String videoUrl, int start, int end) async {
    int retryCount = 0;

    while (retryCount < ApiConstants.maxRetries) {
      try {
        log("streaming video : $videoUrl");
        final String url = videoUrl.split('/').last;

        final response = await dio.request(
          '${dotenv.get(AppKeys.envApiLinkKey)}videos/stream/$url',
          options: Options(
            method: 'GET',
            headers: {
              'Range': 'bytes=$start-$end',
              'Authorization': 'Bearer ${MemoryCache.getUserData()!.token}',
            },
            responseType: ResponseType.bytes,
          ),
        );

        if (response.statusCode == 206 || response.statusCode == 200) {
          final chunkData = Uint8List.fromList(response.data);
          late final StreamVideoMetadata metadata;

          // Extract metadata from headers (available in every response)
          final contentLength = response.headers.value('content-length');
          final contentType =
              response.headers.value('content-type') ?? 'video/mp4';
          final contentRange = response.headers.value('content-range');

          int totalFileSize = 0;

          // Parse total size from Content-Range header (format: "bytes start-end/totalSize")
          if (contentRange != null) {
            final parts = contentRange.split('/');
            if (parts.length == 2) {
              totalFileSize = int.tryParse(parts[1]) ?? 0;
            }
          }

          // Fallback to Content-Length if Content-Range not available
          if (totalFileSize == 0 && contentLength != null) {
            totalFileSize = int.tryParse(contentLength) ?? 0;
          }

          if (totalFileSize > 0) {
            metadata = StreamVideoMetadata(
              totalSize: totalFileSize,
              format: contentType,
            );
          }

          return StreamResponse(
            data: chunkData,
            metadata: metadata,
            start: start,
            end: end,
          );
        } else {
          throw UserFriendlyException(
              ErrorManager.getAPIErrorMessage(response.statusCode));
        }
      } catch (e) {
        retryCount++;
        if (retryCount >= ApiConstants.maxRetries) {
          throw Exception(
              'Failed to download chunk after ${ApiConstants.maxRetries} attempts: $e');
        }
        await Future.delayed(ApiConstants.retryDelay);
      }
    }

    throw Exception('Max retries exceeded');
  }

  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  //*--------------------
  //? get all comments
  //*--------------------
  Future<List<Comment>> getComments(String videoUrl) async {
    final fileName = videoUrl.split('/').last;

    final response = await dio.request(
      '${dotenv.get(AppKeys.envApiLinkKey)}comments/video/$fileName',
      options: Options(
        method: 'GET',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${MemoryCache.getUserData()!.token}',
        },
      ),
    );

    if (response.statusCode == 200) {
      return (response.data["comments"] as List<dynamic>)
          .map((commentJson) => Comment.fromJson(commentJson))
          .toList();
    }

    throw UserFriendlyException(
        ErrorManager.getAPIErrorMessage(response.statusCode));
  }

  //*--------------------
  //? add comment
  //*--------------------
  Future<void> addComment(String videoUrl, String comment) async {
    final fileName = videoUrl.split('/').last;
    final userId = MemoryCache.getUserData()!.id;

    log("adding comment for video: $fileName");
    log("user token: ${MemoryCache.getUserData()!.token}");
    log("user id: $userId");
    log("comment: $comment");

    final response = await dio.request(
      '${dotenv.get(AppKeys.envApiLinkKey)}comments/add',
      options: Options(
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${MemoryCache.getUserData()!.token}',
        },
      ),
      data: {
        'fileName': fileName,
        'content': comment,
        'userId': userId,
      },
    );

    if (response.statusCode == 200) {
      return;
    }

    throw UserFriendlyException(
        ErrorManager.getAPIErrorMessage(response.statusCode));
  }

  Future<void> submitAssignment(
      {required int assignmentId, required Map<int, String> answers}) async {
    final response = await dio.request(
      '${dotenv.get(AppKeys.envApiLinkKey)}assignments/submit',
      options: Options(
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${MemoryCache.getUserData()!.token}',
        },
      ),
      data: {
        'assignmentId': assignmentId,
        'answers': answers,
      },
    );

    if (response.statusCode == 200) {
      return;
    }

    throw UserFriendlyException(
        ErrorManager.getAPIErrorMessage(response.statusCode));
  }
}
