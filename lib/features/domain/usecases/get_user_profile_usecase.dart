import 'package:ElevatED/features/data/data%20sources/cache/memory_cache.dart';
import 'package:ElevatED/features/data/models/user_data.dart';
import 'package:ElevatED/features/domain/repositories/user_repository.dart';

class GetUserProfileUseCase {
  final UserRepository repository;
  GetUserProfileUseCase(this.repository);

  Future<UserData> call(int userId) async {
    final userData = await repository.getUserProfile(userId);
    final String token = MemoryCache.getUserData()!.token;
    userData.token = token;
    MemoryCache.pushUserData(userData);
    return userData;
  }
}
