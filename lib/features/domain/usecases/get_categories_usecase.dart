import 'package:ElevatED/features/data/models/course/course_category.dart';
import 'package:ElevatED/features/domain/repositories/app_repository.dart';

class GetCategoriesUseCase {
  final AppRepository repository;

  GetCategoriesUseCase(this.repository);

  Future<List<CourseCategory>> call() async {
    return await repository.getCategories();
  }
}
