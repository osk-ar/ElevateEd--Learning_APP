import 'package:ElevatED/features/domain/entities/home.dart';
import 'package:ElevatED/features/domain/repo/main_repository.dart';

class GetHomeusecase {
  final MainRepository repository;

  GetHomeusecase(this.repository);

  Future<Home> call(int id) async => await repository.getHome(id);
}
