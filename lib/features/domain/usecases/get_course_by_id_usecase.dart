import 'package:ElevatED/features/data/models/course/course.dart';
import 'package:ElevatED/features/domain/repositories/app_repository.dart';

class GetCourseByIdUseCase {
  final AppRepository repository;
  GetCourseByIdUseCase(this.repository);

  Future<Course> call({
    required int courseId,
  }) {
    return repository.getCourseById(
      courseId: courseId,
    );
  }
}
