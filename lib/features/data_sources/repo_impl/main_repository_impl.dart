import 'package:e_learning_app_gp/features/data_sources/api/remote_data_source.dart';
import 'package:e_learning_app_gp/features/data_sources/models/home_response_model.dart';
import 'package:e_learning_app_gp/features/domain/repo/main_repository.dart';
import 'package:e_learning_app_gp/features/domain/entities/home.dart';

class MainRepositoryImpl extends MainRepository {
  final RemoteDataSource remoteDataSource;

  MainRepositoryImpl(this.remoteDataSource);

  @override
  Future<Home> getHome(int id) async {
    HomeResponseModel homeModel = await remoteDataSource.getHome(id);

    return Home(
        userName: homeModel.userName,
        totalCourses: homeModel.totalCourses,
        totalLearningTime: homeModel.totalLearningTime,
        todayLearningHours: homeModel.todayLearningHours,
        learningHoursDataPoints: homeModel.learningHoursDataPoints);
  }
}
