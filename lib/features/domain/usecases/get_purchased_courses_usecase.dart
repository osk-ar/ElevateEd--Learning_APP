import 'package:ElevatED/features/data/models/view/normalized_course.dart';
import 'package:ElevatED/features/domain/repositories/app_repository.dart';

class GetPurchasedCoursesUseCase {
  final AppRepository repository;

  GetPurchasedCoursesUseCase(this.repository);

  Future<List<NormalizedCourse>> call() async {
    return await repository.getPurchasedCourses();
  }
}
