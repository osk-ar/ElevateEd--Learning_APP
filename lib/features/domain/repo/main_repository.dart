import 'package:e_learning_app_gp/features/domain/entities/home.dart';

abstract class MainRepository {
  Future<Home> getHome(int id);
}
