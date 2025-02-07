import 'package:dio/dio.dart';
import 'package:e_learning_app_gp/features/data_sources/api/remote_data_source.dart';
import 'package:e_learning_app_gp/features/data_sources/local/app_prefs.dart';
import 'package:e_learning_app_gp/features/data_sources/repo_impl/auth_repository.dart';
import 'package:e_learning_app_gp/features/domain/repo/auth_repository.dart';
import 'package:e_learning_app_gp/features/domain/usecases/facebook_auth_usecase.dart';
import 'package:e_learning_app_gp/features/domain/usecases/google_auth_usecase.dart';
import 'package:e_learning_app_gp/features/domain/usecases/login_usecase.dart';
import 'package:e_learning_app_gp/features/domain/usecases/register_usecase.dart';
import 'package:e_learning_app_gp/features/domain/usecases/user_exist_usecase.dart';
import 'package:e_learning_app_gp/features/presentation/cubits/login_cubit.dart';
import 'package:e_learning_app_gp/features/presentation/cubits/register_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:e_learning_app_gp/core/helper/dio_factory.dart';

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

  /// UseCases
  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(sl()));
  sl.registerLazySingleton<RegisterUseCase>(() => RegisterUseCase(sl()));
  sl.registerLazySingleton<UserExistUseCase>(() => UserExistUseCase(sl()));
  sl.registerLazySingleton<GoogleAuthUseCase>(() => GoogleAuthUseCase(sl()));
  sl.registerLazySingleton<FacebookAuthUseCase>(
      () => FacebookAuthUseCase(sl()));

  /// Cubits
  sl.registerFactory<LoginCubit>(() => LoginCubit(sl(), sl(), sl(), sl()));
  sl.registerLazySingleton<RegisterCubit>(
      () => RegisterCubit(sl(), sl(), sl()));
}
