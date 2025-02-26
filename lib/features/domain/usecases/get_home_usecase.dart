import 'package:ElevatED/features/domain/entities/home.dart';
import 'package:ElevatED/features/domain/repo/main_repository.dart';

class GetHomeusecase {
  final MainRepository _authRepository;

  GetHomeusecase(this._authRepository);

  Future<Home> call(int id) async => await _authRepository.getHome(id);
}
