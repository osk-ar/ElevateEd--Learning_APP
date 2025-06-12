import 'package:ElevatED/features/domain/repositories/app_repository.dart';

class BuyCourseUseCase {
  final AppRepository repository;

  BuyCourseUseCase(this.repository);

  Future<String> call({
    required int userId,
    required int courseId,
  }) async {
    return await repository.buyCourse(
      userId: userId,
      courseId: courseId,
    );
  }
}
