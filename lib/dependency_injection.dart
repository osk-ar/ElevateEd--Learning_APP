import 'dart:developer';

import 'package:ElevatED/core/services/Language%20Service/language_service.dart';
import 'package:ElevatED/core/services/image%20services/image_services.dart';
import 'package:ElevatED/core/services/image%20services/image_services_impl.dart';
import 'package:ElevatED/core/services/theme%20service/theme_services.dart';
import 'package:ElevatED/features/data/repositories/app_repository_impl.dart';
import 'package:ElevatED/features/domain/repositories/app_repository.dart';
import 'package:ElevatED/features/domain/usecases/reset_password_usecase.dart';
import 'package:ElevatED/features/domain/usecases/send_otp_usecase.dart';
import 'package:ElevatED/features/domain/usecases/verify_otp_usecase.dart';
import 'package:ElevatED/features/presentation/11_upload_course/cubits/upload_course_cubit.dart';
import 'package:ElevatED/features/presentation/5_forget_password/cubit/change_password_cubit.dart';
import 'package:ElevatED/features/presentation/5_forget_password/cubit/validation_cubit.dart';
import 'package:ElevatED/features/presentation/5_forget_password/cubit/verification_cubit.dart';
import 'package:ElevatED/features/presentation/10_create_course/cubit/create_course_cubit.dart';
import 'package:ElevatED/features/presentation/10_create_course/cubit/pricing_cubit.dart';
import 'package:ElevatED/features/presentation/6_main/cubits/stats_cubit.dart';
import 'package:ElevatED/features/presentation/6_main/cubits/instructor_creativity_cubit.dart';
import 'package:ElevatED/features/presentation/settings/cubits/language_cubit.dart';
import 'package:ElevatED/features/presentation/settings/cubits/notifications_cubit.dart';
import 'package:ElevatED/features/presentation/settings/cubits/theme_cubit.dart';
import 'package:ElevatED/features/presentation/under_shit/course_video_cubit.dart';
import 'package:ElevatED/init.dart';
import 'package:dio/dio.dart';
import 'package:ElevatED/features/data/data%20sources/api/remote_data_source.dart';
import 'package:ElevatED/core/services/Shared%20Preferences%20Service/shared_preferences_service.dart';
import 'package:ElevatED/features/data/repositories/auth_repository_impl.dart';
import 'package:ElevatED/features/data/repositories/user_repository_impl.dart';
import 'package:ElevatED/features/domain/repositories/auth_repository.dart';
import 'package:ElevatED/features/domain/repositories/user_repository.dart';
import 'package:ElevatED/features/domain/usecases/login_usecase.dart';
import 'package:ElevatED/features/domain/usecases/register_usecase.dart';
import 'package:ElevatED/features/presentation/course_details/cubits/course_details_cubit.dart';
import 'package:ElevatED/features/presentation/3_register/cubits/instructor_register_cubit.dart';
import 'package:ElevatED/features/presentation/4_login/cubits/login_cubit.dart';
import 'package:ElevatED/features/presentation/3_register/cubits/register_cubit.dart';
import 'package:ElevatED/features/presentation/3_register/cubits/student_register_cubit.dart';
import 'package:ElevatED/features/presentation/1_splash/cubits/splash_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ElevatED/core/managers/dio_manager.dart';
import 'package:ElevatED/features/domain/usecases/get_courses_usecase.dart';
import 'package:ElevatED/features/presentation/6_main/cubits/courses_cubit.dart';
import 'package:ElevatED/features/domain/usecases/get_course_by_id_usecase.dart';
import 'package:ElevatED/features/domain/usecases/buy_course_usecase.dart';
import 'package:ElevatED/features/domain/usecases/get_categories_usecase.dart';
import 'package:ElevatED/features/domain/usecases/get_purchased_courses_usecase.dart';
import 'package:ElevatED/features/domain/usecases/get_user_profile_usecase.dart';
import 'package:ElevatED/features/presentation/6_main/cubits/visit_profile_cubit.dart';
import 'package:ElevatED/features/presentation/6_main/cubits/edit_profile_cubit.dart';

Future<void> registerDependencies() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  Dio dio = await DioManager.getDio();
  sl.registerLazySingleton<Dio>(() => dio);

  /// Custom Classes
  sl.registerLazySingleton<SharedPreferencesService>(
      () => SharedPreferencesService(sharedPreferences));
  sl.registerLazySingleton<ThemeService>(() => ThemeService(sl()));
  sl.registerLazySingleton<LanguageService>(() => LanguageService());
  sl.registerLazySingleton<ImageServices>(() => ImageServicesImpl());

  /// Data Sources
  sl.registerLazySingleton<RemoteDataSource>(() => RemoteDataSource(sl()));

  /// Repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(sl()));
  sl.registerLazySingleton<AppRepository>(() => AppRepositoryImpl(sl()));

  /// UseCases
  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(sl()));
  sl.registerLazySingleton<RegisterUseCase>(() => RegisterUseCase(sl()));

  sl.registerLazySingleton<SendOtpUsecase>(() => SendOtpUsecase(sl()));
  sl.registerLazySingleton<VerifyOtpUsecase>(() => VerifyOtpUsecase(sl()));
  sl.registerLazySingleton<ResetPasswordUsecase>(
      () => ResetPasswordUsecase(sl()));
  sl.registerLazySingleton<GetCoursesUseCase>(() => GetCoursesUseCase(sl()));
  sl.registerLazySingleton<GetCourseByIdUseCase>(
      () => GetCourseByIdUseCase(sl()));
  sl.registerLazySingleton<BuyCourseUseCase>(() => BuyCourseUseCase(sl()));
  sl.registerLazySingleton<GetCategoriesUseCase>(
      () => GetCategoriesUseCase(sl()));
  sl.registerLazySingleton<GetPurchasedCoursesUseCase>(
      () => GetPurchasedCoursesUseCase(sl()));
  sl.registerLazySingleton<GetUserProfileUseCase>(
      () => GetUserProfileUseCase(sl()));

  /// Cubits
  sl.registerFactory<SplashCubit>(() => SplashCubit(sl(), sl()));

  sl.registerFactory<LoginCubit>(() => LoginCubit(sl(), sl()));
  sl.registerFactory<ValidationCubit>(() => ValidationCubit(sl()));
  sl.registerFactory<VerificationCubit>(() => VerificationCubit(sl(), sl()));
  sl.registerFactory<ChangePasswordCubit>(() => ChangePasswordCubit());

  sl.registerFactory<RegisterCubit>(() => RegisterCubit());
  sl.registerFactory<StudentRegisterCubit>(
      () => StudentRegisterCubit(sl(), sl(), sl(), sl()));
  sl.registerFactory<InstructorRegisterCubit>(
      () => InstructorRegisterCubit(sl(), sl(), sl(), sl()));

  sl.registerFactory<ThemeCubit>(() => ThemeCubit(sl()));
  sl.registerFactory<LanguageCubit>(() => LanguageCubit(sl()));
  sl.registerFactory<NotificationCubit>(() => NotificationCubit());

  sl.registerFactory<CourseDetailsCubit>(() => CourseDetailsCubit(sl(), sl()));
  sl.registerFactory<CourseVideoCubit>(() => CourseVideoCubit());
  sl.registerFactory<StatsCubit>(() => StatsCubit());

  sl.registerFactory<CreateCourseCubit>(() => CreateCourseCubit(sl(), sl()));
  sl.registerFactory<PricingCubit>(() => PricingCubit());

  sl.registerLazySingleton<UploadCourseCubit>(() => UploadCourseCubit(sl()));

  sl.registerFactory<CoursesCubit>(() => CoursesCubit(sl(), sl(), sl()));

  // New Cubits
  sl.registerFactory<VisitProfileCubit>(() => VisitProfileCubit(sl()));
  sl.registerFactory<EditProfileCubit>(() => EditProfileCubit());
  sl.registerFactory<InstructorCreativityCubit>(
      () => InstructorCreativityCubit(sl()));
}
