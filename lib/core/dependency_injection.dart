import 'package:dio/dio.dart';
import 'package:ElevatED/features/data_sources/api/remote_data_source.dart';
import 'package:ElevatED/features/data_sources/local/app_prefs.dart';
import 'package:ElevatED/features/data_sources/repo_impl/auth_repository_impl.dart';
import 'package:ElevatED/features/data_sources/repo_impl/main_repository_impl.dart';
import 'package:ElevatED/features/domain/repo/auth_repository.dart';
import 'package:ElevatED/features/domain/repo/main_repository.dart';
import 'package:ElevatED/features/domain/usecases/get_homeusecase.dart';
import 'package:ElevatED/features/domain/usecases/login_usecase.dart';
import 'package:ElevatED/features/domain/usecases/register_usecase.dart';
import 'package:ElevatED/features/presentation/course_details/cubits/course_details_cubit.dart';
import 'package:ElevatED/features/presentation/register/cubits/instructor_register_cubit.dart';
import 'package:ElevatED/features/presentation/login/cubits/login_cubit.dart';
import 'package:ElevatED/features/presentation/register/cubits/register_cubit.dart';
import 'package:ElevatED/features/presentation/register/cubits/student_register_cubit.dart';
import 'package:ElevatED/features/presentation/splash/cubits/splash_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ElevatED/core/helper/dio_factory.dart';

// import '../features/domain/usecases/delete_account_usecase.dart';
// import '../features/presentation/cubit/create_question_answers_cubit.dart';
// import '../features/presentation/cubit/upload_image_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var dio = await DioFactory().getDio();
  sl.registerLazySingleton<Dio>(() => dio);

  /// Repositories
  sl.registerLazySingleton<AppPrefs>(() => AppPrefsImpl(sharedPreferences));
  sl.registerLazySingleton<RemoteDataSource>(() => RemoteDataSource(sl()));
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton<MainRepository>(() => MainRepositoryImpl(sl()));

  /// UseCases
  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(sl()));
  sl.registerLazySingleton<RegisterUseCase>(() => RegisterUseCase(sl()));
  sl.registerLazySingleton<GetHomeusecase>(() => GetHomeusecase(sl()));

  /// Cubits
  sl.registerFactory<LoginCubit>(() => LoginCubit(sl(), sl()));
  sl.registerFactory<RegisterCubit>(() => RegisterCubit());
  sl.registerFactory<StudentRegisterCubit>(
      () => StudentRegisterCubit(sl(), sl(), sl()));
  sl.registerFactory<InstructorRegisterCubit>(
      () => InstructorRegisterCubit(sl(), sl(), sl()));
  sl.registerFactory<CourseDetailsCubit>(() => CourseDetailsCubit());
  sl.registerFactory<SplashCubit>(() => SplashCubit(sl(), sl()));
}
