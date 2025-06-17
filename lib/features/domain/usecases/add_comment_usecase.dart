import 'package:ElevatED/features/domain/repositories/app_repository.dart';

class AddCommentUseCase {
  final AppRepository repository;

  AddCommentUseCase(this.repository);

  Future<void> call(String videoUrl, String comment) async {
    await repository.addComment(videoUrl, comment);
  }
}
