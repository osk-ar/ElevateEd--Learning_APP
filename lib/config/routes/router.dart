import 'package:e_learning_app_gp/config/routes/route_constants.dart';
import 'package:e_learning_app_gp/core/dependency_injection.dart';
import 'package:e_learning_app_gp/features/presentation/cubits/login_cubit.dart';
import 'package:e_learning_app_gp/features/presentation/cubits/register_cubit.dart';
import 'package:e_learning_app_gp/features/presentation/screens/course_details/course_details_screen.dart';
import 'package:e_learning_app_gp/features/presentation/screens/home_screen/home_screen.dart';
import 'package:e_learning_app_gp/features/presentation/screens/instuctor_screen/instuctor_screen.dart';
import 'package:e_learning_app_gp/features/presentation/screens/login_screen/login_screen.dart';
import 'package:e_learning_app_gp/features/presentation/screens/on_boarding_screen/on_boarding_screen.dart';
import 'package:e_learning_app_gp/features/presentation/screens/progress_screen/progress_screen.dart';
import 'package:e_learning_app_gp/features/presentation/screens/register_screen/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RouteGenerator {
  RouteGenerator._();

  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.onBoardingScreenRoute:
        return MaterialPageRoute(
          builder: (context) => const OnBoardingScreen(),
        );
      case Routes.homeScreenRoute:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
      case Routes.progressScreenRoute:
        return MaterialPageRoute(
          builder: (context) => const ProgressScreen(),
        );
      case Routes.courseDetailsScreenRoute:
        return MaterialPageRoute(
          builder: (context) => const CourseDetailsScreen(),
        );
      case Routes.instructorScreenRoute:
        return MaterialPageRoute(
          builder: (context) => const InstructorScreen(),
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
          builder: (context) => BlocProvider<RegisterCubit>.value(
            value: sl<RegisterCubit>(),
            child: const RegisterScreen(),
          ),
        );

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
