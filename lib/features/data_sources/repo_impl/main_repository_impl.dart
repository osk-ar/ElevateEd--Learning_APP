import 'package:ElevatED/features/data_sources/api/remote_data_source.dart';
import 'package:ElevatED/features/data_sources/models/home_response_model.dart';
import 'package:ElevatED/features/domain/repo/main_repository.dart';
import 'package:ElevatED/features/domain/entities/home.dart';

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
