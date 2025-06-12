import 'package:ElevatED/features/data/models/assignment/assignment.dart';
import 'package:ElevatED/features/data/models/course/course.dart';
import 'package:ElevatED/features/data/models/course/course_category.dart';
import 'package:ElevatED/features/data/models/upload/upload_course_model.dart';
import 'package:ElevatED/features/data/models/video/upload_video_initialize.dart';
import 'package:ElevatED/features/data/models/video/video_chunk_model.dart';
import 'package:ElevatED/features/data/models/view/normalized_course.dart';

abstract class AppRepository {
  Future<List<CourseCategory>> getCategories();

  //?-------------------------- create course
  Future<int> uploadCourseDetails(UploadCourseModel course);
  Future<void> uploadCourseAssignment(Assignment assignment, int courseID);

  Future<String> uploadVideoInitialize(UploadVideoInitializeModel videoModel);
  Future<void> uploadVideoChunk(VideoChunkModel chunk);
  Future<void> uploadVideoFinalize(String uploadID);
  //?-------------------------- create course

  Future<List<NormalizedCourse>> getCourses({
    required int page,
    required int pageSize,
  });

  Future<List<NormalizedCourse>> getPurchasedCourses();

  Future<Course> getCourseById({
    required int courseId,
  });

  //?-------------------------- buy course
  Future<String> buyCourse({
    required int userId,
    required int courseId,
  });
  //?-------------------------- buy course
}
