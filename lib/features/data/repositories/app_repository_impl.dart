import 'package:ElevatED/features/data/data%20sources/api/remote_data_source.dart';
import 'package:ElevatED/features/data/models/assignment/assignment.dart';
import 'package:ElevatED/features/data/models/course/course.dart';
import 'package:ElevatED/features/data/models/course/course_category.dart';
import 'package:ElevatED/features/data/models/upload/upload_course_model.dart';
import 'package:ElevatED/features/data/models/user_data.dart';
import 'package:ElevatED/features/data/models/video/upload_video_initialize.dart';
import 'package:ElevatED/features/data/models/video/video_chunk_model.dart';
import 'package:ElevatED/features/data/models/view/normalized_course.dart';
import 'package:ElevatED/features/domain/repositories/app_repository.dart';
import 'package:ElevatED/features/data/data sources/cache/memory_cache.dart';
import 'package:ElevatED/features/data/models/video/comment.dart';

class AppRepositoryImpl extends AppRepository {
  final RemoteDataSource remoteDataSource;

  AppRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<CourseCategory>> getCategories() async {
    List<CourseCategory> categories = await remoteDataSource.getCategories();
    return categories;
  }

  @override
  Future<void> uploadCourseAssignment(
      Assignment assignment, int courseID) async {
    await remoteDataSource.uploadCourseAssignment(assignment, courseID);
  }

  @override
  Future<int> uploadCourseDetails(UploadCourseModel course) async {
    return await remoteDataSource.uploadCourseDetails(course);
  }

  @override
  Future<void> uploadVideoChunk(VideoChunkModel chunk) async {
    await remoteDataSource.uploadVideoChunk(chunk);
  }

  @override
  Future<void> uploadVideoFinalize(String uploadID) async {
    await remoteDataSource.uploadVideoFinalize(uploadID);
  }

  @override
  Future<String> uploadVideoInitialize(
      UploadVideoInitializeModel videoModel) async {
    return await remoteDataSource.uploadVideoInitialize(videoModel);
  }

  @override
  Future<List<NormalizedCourse>> getCourses({
    required int page,
    required int pageSize,
  }) async {
    final courses = await remoteDataSource.getAllCourses(
      page: page,
      pageSize: pageSize,
    );
    MemoryCache.pushAllCourses(courses);
    return courses;
  }

  @override
  Future<List<NormalizedCourse>> refreshUserPurchasedCourses() async {
    final userData = MemoryCache.getUserData();
    if (userData == null) {
      throw Exception('User not logged in');
    }

    try {
      // Store the current token
      final currentToken = userData.token;

      // Get fresh user data
      UserData newUserData = await remoteDataSource.getUserProfile(userData.id);

      // Preserve the token as it's not included in the profile response
      newUserData.token = currentToken;

      // Update the cache with fresh data
      MemoryCache.pushUserData(newUserData);

      return newUserData.purchasedCourses;
    } catch (e) {
      throw Exception('Failed to refresh purchased courses: ${e.toString()}');
    }
  }

  @override
  Future<List<NormalizedCourse>> getPurchasedCourses() async {
    // For backward compatibility, call the new refresh method
    return refreshUserPurchasedCourses();
  }

  @override
  Future<Course> getCourseById({
    required int courseId,
  }) async {
    final userId = MemoryCache.getUserData()?.id;
    if (userId == null) {
      throw Exception('User not logged in');
    }
    return await remoteDataSource.getCourseByID(
      userId: userId,
      courseId: courseId,
    );
  }

  @override
  Future<String> buyCourse({
    required int userId,
    required int courseId,
  }) async {
    return await remoteDataSource.buyCourse(
      userId: userId,
      courseId: courseId,
    );
  }

  @override
  Future<List<Comment>> getComments(String videoUrl) async {
    return await remoteDataSource.getComments(videoUrl);
  }

  @override
  Future<void> addComment(String videoUrl, String comment) async {
    await remoteDataSource.addComment(videoUrl, comment);
  }

  @override
  Future<void> submitAssignment(
      {required int assignmentId, required Map<int, String> answers}) async {
    await remoteDataSource.submitAssignment(
        assignmentId: assignmentId, answers: answers);
  }

  @override
  Future<void> sendActivityPoint({
    required int userId,
    required double hours,
  }) async {
    await remoteDataSource.sendActivityPoint(
      userId: userId,
      hours: hours,
    );
  }
}
