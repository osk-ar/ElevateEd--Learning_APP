import 'package:ElevatED/core/helper/theme_helpers.dart';
import 'package:ElevatED/features/data_sources/local/disk_cache.dart';
import 'package:ElevatED/features/domain/usecases/reset_password_usecase.dart';
import 'package:ElevatED/features/domain/usecases/send_otp_usecase.dart';
import 'package:ElevatED/features/domain/usecases/verify_otp_usecase.dart';
import 'package:ElevatED/features/presentation/forget_password/cubit/change_password_cubit.dart';
import 'package:ElevatED/features/presentation/forget_password/cubit/validation_cubit.dart';
import 'package:ElevatED/features/presentation/forget_password/cubit/verification_cubit.dart';
import 'package:ElevatED/features/presentation/settings/cubits/language_cubit.dart';
import 'package:ElevatED/features/presentation/settings/cubits/notifications_cubit.dart';
import 'package:ElevatED/features/presentation/settings/cubits/theme_cubit.dart';
import 'package:dio/dio.dart';
import 'package:ElevatED/features/data_sources/api/remote_data_source.dart';
import 'package:ElevatED/features/data_sources/local/app_prefs.dart';
import 'package:ElevatED/features/data_sources/repo_impl/auth_repository_impl.dart';
import 'package:ElevatED/features/data_sources/repo_impl/main_repository_impl.dart';
import 'package:ElevatED/features/domain/repo/auth_repository.dart';
import 'package:ElevatED/features/domain/repo/main_repository.dart';
import 'package:ElevatED/features/domain/usecases/get_home_usecase.dart';
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

  /// Custom Classes
  sl.registerLazySingleton<DiskCache>(() => DiskCacheImpl(sharedPreferences));
  sl.registerLazySingleton<ThemeHelpers>(() => ThemeHelpers(sl()));

  /// Data Sources
  sl.registerLazySingleton<AppPrefs>(() => AppPrefsImpl(sharedPreferences));
  sl.registerLazySingleton<RemoteDataSource>(() => RemoteDataSource(sl()));

  /// Repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton<MainRepository>(() => MainRepositoryImpl(sl()));

  /// UseCases
  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(sl()));
  sl.registerLazySingleton<RegisterUseCase>(() => RegisterUseCase(sl()));
  sl.registerLazySingleton<GetHomeusecase>(() => GetHomeusecase(sl()));

  sl.registerLazySingleton<SendOtpUsecase>(() => SendOtpUsecase(sl()));
  sl.registerLazySingleton<VerifyOtpUsecase>(() => VerifyOtpUsecase(sl()));
  sl.registerLazySingleton<ResetPasswordUsecase>(
      () => ResetPasswordUsecase(sl()));

  /// Cubits
  sl.registerFactory<SplashCubit>(() => SplashCubit(sl(), sl()));

  sl.registerFactory<LoginCubit>(() => LoginCubit(sl(), sl()));
  sl.registerFactory<ValidationCubit>(() => ValidationCubit(sl()));
  sl.registerFactory<VerificationCubit>(() => VerificationCubit(sl(), sl()));
  sl.registerFactory<ChangePasswordCubit>(() => ChangePasswordCubit());

  sl.registerFactory<RegisterCubit>(() => RegisterCubit());
  sl.registerFactory<StudentRegisterCubit>(
      () => StudentRegisterCubit(sl(), sl(), sl()));
  sl.registerFactory<InstructorRegisterCubit>(
      () => InstructorRegisterCubit(sl(), sl(), sl()));

  sl.registerFactory<ThemeCubit>(() => ThemeCubit(sl(), sl()));
  sl.registerFactory<LanguageCubit>(() => LanguageCubit(sl()));
  sl.registerFactory<NotificationCubit>(() => NotificationCubit(sl()));
  sl.registerFactory<CourseDetailsCubit>(() => CourseDetailsCubit());
}
