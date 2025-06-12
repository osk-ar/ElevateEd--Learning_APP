import 'package:ElevatED/features/data/data%20sources/cache/memory_cache.dart';
import 'package:ElevatED/features/data/models/user_data.dart';
import 'package:ElevatED/features/domain/repositories/user_repository.dart';

class GetVisitedProfileUseCase {
  final UserRepository repository;
  GetVisitedProfileUseCase(this.repository);

  Future<UserData> call(int userId) async {
    final userData = await repository.getUserProfile(userId);
    MemoryCache.pushVisitedUserData(userData);
    return userData;
  }
}
