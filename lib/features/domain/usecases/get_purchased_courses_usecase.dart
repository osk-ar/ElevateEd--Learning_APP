import 'package:ElevatED/features/data/models/view/normalized_course.dart';
import 'package:ElevatED/features/domain/repositories/app_repository.dart';

class GetPurchasedCoursesUseCase {
  final AppRepository repository;

  GetPurchasedCoursesUseCase(this.repository);

  /// Fetches fresh purchased courses by refreshing the user profile data.
  /// This ensures we always get the latest purchased courses.
  /// Returns a list of purchased courses or throws an exception if user is not logged in.
  Future<List<NormalizedCourse>> call() async {
    try {
      return await repository.refreshUserPurchasedCourses();
    } catch (e) {
      throw Exception('Failed to fetch purchased courses: ${e.toString()}');
    }
  }
}
