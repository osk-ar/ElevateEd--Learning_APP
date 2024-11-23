import 'package:dio/dio.dart';
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
  // sl.registerLazySingleton<AppPrefs>(() => AppPrefsImpl(sharedPreferences));
  // sl.registerLazySingleton<RemoteDataSource>(() => RemoteDataSource(sl()));
  // sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  // sl.registerLazySingleton<AccountRepository>(() => AccountRepositoryImpl(sl()));
  // sl.registerLazySingleton<QuizRepository>(() => QuizRepositoryImpl(sl()));

  // UseCases
  // sl.registerLazySingleton<GetProfileDataUseCase>(() => GetProfileDataUseCase(sl()));

  /// Cubits
  // sl.registerLazySingleton<RegisterCubit>(() => RegisterCubit(sl(),sl(),sl()));
  // sl.registerFactory<LoginCubit>(() => LoginCubit(sl(),sl(),sl(),sl()));
}
