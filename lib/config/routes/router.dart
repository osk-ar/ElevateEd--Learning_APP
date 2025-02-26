import 'package:ElevatED/config/routes/route_constants.dart';
import 'package:ElevatED/core/dependency_injection.dart';
import 'package:ElevatED/features/presentation/course_details/cubits/course_details_cubit.dart';
import 'package:ElevatED/features/presentation/forget_password/cubit/change_password_cubit.dart';
import 'package:ElevatED/features/presentation/forget_password/cubit/validation_cubit.dart';
import 'package:ElevatED/features/presentation/forget_password/cubit/verification_cubit.dart';
import 'package:ElevatED/features/presentation/forget_password/screens/change_password_screen.dart';
import 'package:ElevatED/features/presentation/forget_password/screens/validation_screen.dart';
import 'package:ElevatED/features/presentation/forget_password/screens/verification_screen.dart';
import 'package:ElevatED/features/presentation/main_page/main_page.dart';
import 'package:ElevatED/features/presentation/register/cubits/instructor_register_cubit.dart';
import 'package:ElevatED/features/presentation/login/cubits/login_cubit.dart';
import 'package:ElevatED/features/presentation/register/cubits/register_cubit.dart';
import 'package:ElevatED/features/presentation/register/cubits/student_register_cubit.dart';
import 'package:ElevatED/features/presentation/course_details/screen/course_details_screen.dart';
import 'package:ElevatED/features/presentation/login/screen/login_screen.dart';
import 'package:ElevatED/features/presentation/on_boarding/on_boarding_screen.dart';
import 'package:ElevatED/features/presentation/settings/screens/settings_screen.dart';
import 'package:ElevatED/features/presentation/settings/screens/sub_screens/language_screen.dart';
import 'package:ElevatED/features/presentation/splash/cubits/splash_cubit.dart';
import 'package:ElevatED/features/presentation/register/screen/register_as_instructor.dart';
import 'package:ElevatED/features/presentation/register/screen/register_as_student.dart';
import 'package:ElevatED/features/presentation/register/screen/register_screen.dart';
import 'package:ElevatED/features/presentation/splash/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RouteGenerator {
  RouteGenerator._();

  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      //* Intro
      case Routes.splashScreenRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<SplashCubit>(
            create: (context) => sl<SplashCubit>(),
            child: const SplashScreen(),
          ),
        );
      case Routes.onBoardingScreenRoute:
        return MaterialPageRoute(
          builder: (context) => const OnBoardingScreen(),
        );

      //* Auth
      case Routes.loginScreenRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<LoginCubit>.value(
            value: sl<LoginCubit>(),
            child: const LoginScreen(),
          ),
        );
      case Routes.forgetPasswordValidationScreenRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<ValidationCubit>(
            create: (context) => sl<ValidationCubit>(),
            child: const ValidationScreen(),
          ),
        );
      case Routes.forgetPasswordVerificationScreenRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<VerificationCubit>(
            create: (context) => sl<VerificationCubit>(),
            child: const VerificationScreen(),
          ),
        );
      case Routes.forgetPasswordChangePasswordScreenRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<ChangePasswordCubit>(
            create: (context) => sl<ChangePasswordCubit>(),
            child: const ChangePasswordScreen(),
          ),
        );
      case Routes.signupScreenRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<RegisterCubit>(
            create: (context) => sl<RegisterCubit>(),
            child: const RegisterScreen(),
          ),
        );
      case Routes.signupAsStudentScreenRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<StudentRegisterCubit>(
            create: (context) => sl<StudentRegisterCubit>(),
            child: const RegisterAsStudent(),
          ),
        );
      case Routes.signupAsInstructorScreenRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<InstructorRegisterCubit>(
            create: (context) => sl<InstructorRegisterCubit>(),
            child: const RegisterAsInstructor(),
          ),
        );

      //* Main
      case Routes.mainScreenRoute:
        return MaterialPageRoute(
          builder: (context) => const MainPage(),
        );

      //* Sub Main
      case Routes.courseDetailsScreenRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<CourseDetailsCubit>(
            create: (context) => sl<CourseDetailsCubit>(),
            child: const courseDetailsScreen(),
          ),
        );

      //!-----------------------------------------------------
      case Routes.settingsScreenRoute:
        return MaterialPageRoute(
          builder: (context) => const SettingsScreen(),
        );
      case Routes.multipleOptionSettingScreenRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<CourseDetailsCubit>(
            create: (context) => sl<CourseDetailsCubit>(),
            child: LanguageScreen(sl()),
          ),
        );
      //!-----------------------------------------------------

      ///login
      // case Routes.logInScreenRoute:
      //   return MaterialPageRoute(
      //     builder: (context) => BlocProvider(
      //         create: (context) => sl<LoginCubit>(),
      //         child: const LoginScreen()),
      //   );

      // case Routes.newPasswordScreenRoute:
      //   return MaterialPageRoute(
      //     builder: (context) => BlocProvider<ForgetPasswordCubit>.value(
      //       value: sl<ForgetPasswordCubit>(),
      //       child: const NewPasswordScreen(),
      //     ),
      //   );

      /// Home
      // case Routes.homeScreenRoute:
      //   return MaterialPageRoute(
      //     builder: (context) => MultiBlocProvider(
      //       providers: [
      //         BlocProvider<HomeProfileCubit>(
      //           create: (context) => sl<HomeProfileCubit>(),
      //         ),
      //         BlocProvider<HomeQuizzesCubit>(
      //           create: (context) => sl<HomeQuizzesCubit>(),
      //         ),
      //         BlocProvider<HomeCategoriesCubit>(
      //           create: (context) => sl<HomeCategoriesCubit>(),
      //         ),
      //       ],
      //       child: const HomePage(),
      //     ),
      //   );

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text("No Route Found"),
        ),
        body: const Center(child: Text("No Route Found")),
      ),
    );
  }
}
