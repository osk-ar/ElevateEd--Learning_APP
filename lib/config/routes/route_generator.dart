import 'dart:developer';

import 'package:ElevatED/config/routes/route_constants.dart';
import 'package:ElevatED/features/data/models/assignment/assignment.dart';
import 'package:ElevatED/features/data/models/upload/upload_course_model.dart';
import 'package:ElevatED/features/presentation/11_upload_course/cubits/upload_course_cubit.dart';
import 'package:ElevatED/features/presentation/11_upload_course/screen/upload_course_screen.dart';
import 'package:ElevatED/features/presentation/10_create_course/create_course_screen.dart';
import 'package:ElevatED/features/presentation/10_create_course/cubits/pricing_cubit.dart';
import 'package:ElevatED/features/presentation/10_create_course/forms/add_assignment_form.dart';
import 'package:ElevatED/features/presentation/10_create_course/forms/add_video_form.dart';
import 'package:ElevatED/features/presentation/6_main/cubits/categories_cubit.dart';
import 'package:ElevatED/features/presentation/6_main/cubits/image_cubit.dart';
import 'package:ElevatED/features/presentation/6_main/cubits/save_profile_cubit.dart';
import 'package:ElevatED/features/presentation/6_main/cubits/stats_cubit.dart';
import 'package:ElevatED/features/presentation/6_main/cubits/instructor_creativity_cubit.dart';
import 'package:ElevatED/features/presentation/6_main/cubits/visit_profile_cubit.dart';
import 'package:ElevatED/features/presentation/chat/chat_screen.dart';
import 'package:ElevatED/features/presentation/course_details/cubits/course_details_cubit.dart';
import 'package:ElevatED/features/presentation/5_forget_password/cubit/change_password_cubit.dart';
import 'package:ElevatED/features/presentation/5_forget_password/cubit/validation_cubit.dart';
import 'package:ElevatED/features/presentation/5_forget_password/cubit/verification_cubit.dart';
import 'package:ElevatED/features/presentation/5_forget_password/screens/change_password_screen.dart';
import 'package:ElevatED/features/presentation/5_forget_password/screens/validation_screen.dart';
import 'package:ElevatED/features/presentation/5_forget_password/screens/verification_screen.dart';
import 'package:ElevatED/features/presentation/6_main/main_page.dart';
import 'package:ElevatED/features/presentation/6_main/sub_screens/profile/visit/visit_profile_screen.dart';
import 'package:ElevatED/features/presentation/3_register/cubits/instructor_register_cubit.dart';
import 'package:ElevatED/features/presentation/4_login/cubits/login_cubit.dart';
import 'package:ElevatED/features/presentation/3_register/cubits/register_cubit.dart';
import 'package:ElevatED/features/presentation/3_register/cubits/student_register_cubit.dart';
import 'package:ElevatED/features/presentation/course_details/screen/course_details_screen.dart';
import 'package:ElevatED/features/presentation/4_login/screen/login_screen.dart';
import 'package:ElevatED/features/presentation/2_on_boarding/on_boarding_screen.dart';
import 'package:ElevatED/features/presentation/settings/cubits/auth_cubit.dart';
import 'package:ElevatED/features/presentation/settings/cubits/language_cubit.dart';
import 'package:ElevatED/features/presentation/settings/cubits/notifications_cubit.dart';
import 'package:ElevatED/features/presentation/settings/cubits/theme_cubit.dart';
import 'package:ElevatED/features/presentation/settings/screens/settings_screen.dart';
import 'package:ElevatED/features/presentation/settings/screens/sub_screens/community_guidelines.dart';
import 'package:ElevatED/features/presentation/settings/screens/sub_screens/language_screen.dart';
import 'package:ElevatED/features/presentation/settings/screens/sub_screens/notification_screen.dart';
import 'package:ElevatED/features/presentation/settings/screens/sub_screens/privacy_policy_screen.dart';
import 'package:ElevatED/features/presentation/settings/screens/sub_screens/theme_screen.dart';
import 'package:ElevatED/features/presentation/1_splash/cubits/splash_cubit.dart';
import 'package:ElevatED/features/presentation/3_register/screen/register_as_instructor.dart';
import 'package:ElevatED/features/presentation/3_register/screen/register_as_student.dart';
import 'package:ElevatED/features/presentation/3_register/screen/register_screen.dart';
import 'package:ElevatED/features/presentation/1_splash/screen/splash_screen.dart';
import 'package:ElevatED/features/presentation/course_content_play/cubit/video/video_streaming_cubit.dart';
import 'package:ElevatED/features/presentation/course_content_play/screens/course_video_screen.dart';
import 'package:ElevatED/features/presentation/6_main/sub_screens/profile/edit/instructor_edit_profile_screen.dart';
import 'package:ElevatED/init.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ElevatED/features/presentation/6_main/cubits/courses_cubit.dart';
import 'package:ElevatED/features/presentation/payment/payment_success_screen.dart';
import 'package:ElevatED/features/presentation/payment/payment_cancel_screen.dart';
import 'package:ElevatED/core/constants/enum.dart';
import 'package:ElevatED/features/data/data sources/cache/memory_cache.dart';
import 'package:ElevatED/features/presentation/6_main/sub_screens/profile/view/instructor_profile_screen.dart';
import 'package:ElevatED/features/presentation/6_main/sub_screens/profile/view/student_profile_screen.dart';
import 'package:ElevatED/features/presentation/6_main/sub_screens/profile/edit/student_edit_profile_screen.dart';
import 'package:ElevatED/features/presentation/course_content_play/cubit/video/video_player_ui_cubit.dart';
import 'package:ElevatED/features/presentation/course_content_play/cubit/video/video_comments_cubit.dart';
import 'package:ElevatED/features/presentation/10_create_course/cubits/content_cubit.dart';
import 'package:ElevatED/features/presentation/10_create_course/cubits/general_cubit.dart';
import 'package:ElevatED/features/presentation/course_content_play/screens/assignment_solver_screen.dart';
import 'package:ElevatED/features/presentation/course_content_play/cubit/assignment/assignment_solver_cubit.dart';

class RouteGenerator {
  RouteGenerator._();

  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      //* Intro
      case RouteConstants.splashScreenRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<SplashCubit>(
            create: (context) => sl<SplashCubit>(),
            child: const SplashScreen(),
          ),
        );
      case RouteConstants.onBoardingScreenRoute:
        return MaterialPageRoute(
          builder: (context) => const OnBoardingScreen(),
        );

      //* Auth
      case RouteConstants.loginScreenRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<LoginCubit>.value(
            value: sl<LoginCubit>(),
            child: const LoginScreen(),
          ),
        );
      case RouteConstants.forgetPasswordValidationScreenRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<ValidationCubit>(
            create: (context) => sl<ValidationCubit>(),
            child: const ValidationScreen(),
          ),
        );
      case RouteConstants.forgetPasswordVerificationScreenRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<VerificationCubit>(
            create: (context) => sl<VerificationCubit>(),
            child: const VerificationScreen(),
          ),
        );
      case RouteConstants.forgetPasswordChangePasswordScreenRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<ChangePasswordCubit>(
            create: (context) => sl<ChangePasswordCubit>(),
            child: const ChangePasswordScreen(),
          ),
        );
      case RouteConstants.signupScreenRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<RegisterCubit>(
            create: (context) => sl<RegisterCubit>(),
            child: const RegisterScreen(),
          ),
        );
      case RouteConstants.signupAsStudentScreenRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<StudentRegisterCubit>(
            create: (context) => sl<StudentRegisterCubit>(),
            child: const RegisterAsStudent(),
          ),
        );
      case RouteConstants.signupAsInstructorScreenRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<InstructorRegisterCubit>(
            create: (context) => sl<InstructorRegisterCubit>(),
            child: const RegisterAsInstructor(),
          ),
        );

      //* Main
      case RouteConstants.mainScreenRoute:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider<CoursesCubit>(
                create: (context) => sl<CoursesCubit>(),
              ),
              BlocProvider<StatsCubit>(
                create: (context) => sl<StatsCubit>(),
              ),
              BlocProvider<InstructorCreativityCubit>(
                create: (context) => sl<InstructorCreativityCubit>(),
              ),
            ],
            child: const MainPage(),
          ),
        );

      //* Sub Main
      case RouteConstants.courseDetailsScreenRoute:
        final courseId = settings.arguments as int;
        return MaterialPageRoute(
          builder: (context) => BlocProvider<CourseDetailsCubit>(
            create: (context) => sl<CourseDetailsCubit>(),
            child: CourseDetailsScreen(courseId: courseId),
          ),
        );
      //!-----------------------------------------------------
      case RouteConstants.createCourseScreenRoute:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider<GeneralCubit>.value(
                value: sl<GeneralCubit>(),
              ),
              BlocProvider<ContentCubit>.value(
                value: sl<ContentCubit>(),
              ),
              BlocProvider<PricingCubit>.value(
                value: sl<PricingCubit>(),
              ),
            ],
            child: const CreateCourseScreen(),
          ),
        );
      case RouteConstants.addVideoFormRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<ContentCubit>.value(
            value: sl<ContentCubit>(),
            child: const AddVideoForm(),
          ),
        );
      case RouteConstants.addAssignmentFormRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<ContentCubit>.value(
            value: sl<ContentCubit>(),
            child: const AddAssignmentForm(),
          ),
        );
      case RouteConstants.uploadCourseScreenRoute:
        final UploadCourseModel courseModel =
            (settings.arguments as UploadCourseModel);
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider<UploadCourseCubit>(
                create: (context) => sl<UploadCourseCubit>(),
              ),
            ],
            child: UploadCourseScreen(courseModel: courseModel),
          ),
        );
      //!-----------------------------------------------------
      //?-----------------------------------------------------
      case RouteConstants.communityScreenRoute:
        return MaterialPageRoute(
          builder: (context) => const ChatScreen(),
        );
      //?-----------------------------------------------------
      case RouteConstants.settingsScreenRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<AuthCubit>(
            create: (context) => sl<AuthCubit>(),
            child: const SettingsScreen(),
          ),
        );
      case RouteConstants.privacyPolicySettingScreenRoute:
        return MaterialPageRoute(
          builder: (context) => const PrivacyPolicyPage(),
        );
      case RouteConstants.communityGuidelinesSettingScreenRoute:
        return MaterialPageRoute(
          builder: (context) => const CommunityGuidelinesPage(),
        );
      case RouteConstants.languageSettingScreenRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<LanguageCubit>(
            create: (context) => sl<LanguageCubit>(),
            child: const LanguageScreen(),
          ),
        );
      case RouteConstants.themeSettingScreenRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<ThemeCubit>(
            create: (context) => sl<ThemeCubit>(),
            child: const ThemeScreen(),
          ),
        );
      case RouteConstants.notificationsSettingScreenRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<NotificationCubit>(
            create: (context) => sl<NotificationCubit>(),
            child: const NotificationScreen(),
          ),
        );
      case RouteConstants.courseVideoScreenRoute:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider<VideoStreamingCubit>(
                create: (context) => sl<VideoStreamingCubit>(),
              ),
              BlocProvider<VideoPlayerUICubit>(
                create: (context) => sl<VideoPlayerUICubit>(),
              ),
              BlocProvider<VideoCommentsCubit>(
                create: (context) => sl<VideoCommentsCubit>(),
              ),
            ],
            child: const CourseVideoScreen(),
          ),
        );
      case RouteConstants.profileScreenRoute:
        final role = MemoryCache.getUserRole() ?? UserRoleEnum.student;
        return MaterialPageRoute(
          builder: (context) => role == UserRoleEnum.instructor
              ? const InstructorProfileScreen()
              : const StudentProfileScreen(),
        );
      case RouteConstants.visitProfileScreenRoute:
        final int userId = settings.arguments as int;
        return MaterialPageRoute(
          builder: (context) => BlocProvider<VisitProfileCubit>(
            create: (context) => sl<VisitProfileCubit>(),
            child: VisitProfileScreen(userId: userId),
          ),
        );
      case RouteConstants.editProfileScreenRoute:
        final role = MemoryCache.getUserData()?.role;
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider<ImageCubit>(
                create: (context) => sl<ImageCubit>(),
              ),
              BlocProvider<SaveProfileCubit>(
                create: (context) => sl<SaveProfileCubit>(),
              ),
              BlocProvider<CategoriesCubit>(
                create: (context) => sl<CategoriesCubit>(),
              ),
            ],
            child: role == UserRoleEnum.instructor
                ? const InstructorEditProfileScreen()
                : const StudentEditProfileScreen(),
          ),
        );

      case RouteConstants.paymentSuccessScreenRoute:
        return MaterialPageRoute(
          builder: (context) => const PaymentSuccessScreen(),
        );

      case RouteConstants.paymentCancelScreenRoute:
        return MaterialPageRoute(
          builder: (context) => const PaymentCancelScreen(),
        );

      case RouteConstants.assignmentSolverScreenRoute:
        final assignment = settings.arguments as Assignment;
        log("assignment: ${assignment.title}");
        return MaterialPageRoute(
          builder: (context) => BlocProvider<AssignmentSolverCubit>.value(
            value: sl<AssignmentSolverCubit>(),
            child: AssignmentSolverScreen(assignment: assignment),
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
        log("in router default case: ${settings.name}");
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
