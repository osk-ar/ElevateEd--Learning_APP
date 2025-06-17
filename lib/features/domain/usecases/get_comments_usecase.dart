import 'package:ElevatED/features/data/models/video/comment.dart';
import 'package:ElevatED/features/domain/repositories/app_repository.dart';

class GetCommentsUseCase {
  final AppRepository repository;

  GetCommentsUseCase(this.repository);

  Future<List<Comment>> call(String videoUrl) async {
    return await repository.getComments(videoUrl);
  }
}
