import 'package:ElevatED/features/data/models/view/normalized_course.dart';
import 'package:ElevatED/features/domain/repositories/app_repository.dart';

class GetCoursesUseCase {
  final AppRepository repository;
  GetCoursesUseCase(this.repository);

  Future<List<NormalizedCourse>> call({
    required int page,
    required int pageSize,
  }) {
    return repository.getCourses(
      page: page,
      pageSize: pageSize,
    );
  }
}
