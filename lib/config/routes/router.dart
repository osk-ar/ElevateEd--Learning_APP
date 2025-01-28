import 'package:e_learning_app_gp/config/routes/route_constants.dart';
import 'package:e_learning_app_gp/core/dependency_injection.dart';
import 'package:e_learning_app_gp/features/presentation/home/cubits/home_cubit.dart';
import 'package:e_learning_app_gp/features/presentation/home/screen/home_screen.dart';
import 'package:e_learning_app_gp/features/presentation/main_page/main_page.dart';
import 'package:e_learning_app_gp/features/presentation/register/cubits/instructor_register_cubit.dart';
import 'package:e_learning_app_gp/features/presentation/login/cubits/login_cubit.dart';
import 'package:e_learning_app_gp/features/presentation/register/cubits/register_cubit.dart';
import 'package:e_learning_app_gp/features/presentation/register/cubits/student_register_cubit.dart';
import 'package:e_learning_app_gp/features/presentation/course_details/course_details_screen.dart';
import 'package:e_learning_app_gp/features/presentation/login/screen/login_screen.dart';
import 'package:e_learning_app_gp/features/presentation/on_boarding/on_boarding_screen.dart';
import 'package:e_learning_app_gp/features/presentation/statistics/statistics_screen.dart';
import 'package:e_learning_app_gp/features/presentation/register/screen/register_as_instructor.dart';
import 'package:e_learning_app_gp/features/presentation/register/screen/register_as_student.dart';
import 'package:e_learning_app_gp/features/presentation/register/screen/register_screen.dart';
import 'package:e_learning_app_gp/features/presentation/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RouteGenerator {
  RouteGenerator._();

  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreenRoute:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case Routes.onBoardingScreenRoute:
        return MaterialPageRoute(
          builder: (context) => const OnBoardingScreen(),
        );
      case Routes.statisticsScreenRoute:
        return MaterialPageRoute(
          builder: (context) => const StatisticsScreen(),
        );
      case Routes.courseDetailsScreenRoute:
        return MaterialPageRoute(
          builder: (context) => const courseDetailsScreen(),
        );
      case Routes.mainScreenRoute:
        return MaterialPageRoute(
          builder: (context) => const MainPage(),
        );

      case Routes.loginScreenRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<LoginCubit>.value(
            value: sl<LoginCubit>(),
            child: const LoginScreen(),
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

      case Routes.homeScreenRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<HomeCubit>(
            create: (context) => sl<HomeCubit>(),
            child: const HomeScreen(),
          ),
        );

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
