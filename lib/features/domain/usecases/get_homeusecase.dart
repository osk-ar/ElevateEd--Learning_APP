import 'package:e_learning_app_gp/features/domain/entities/home.dart';
import 'package:e_learning_app_gp/features/domain/repo/main_repository.dart';

class GetHomeusecase {
  final MainRepository repository;

  GetHomeusecase(this.repository);

  Future<Home> call(int id) async => await repository.getHome(id);
}
