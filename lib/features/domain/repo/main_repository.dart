import 'package:ElevatED/features/domain/entities/home.dart';

abstract class MainRepository {
  Future<Home> getHome(int id);
}
