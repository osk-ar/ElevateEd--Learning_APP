import 'package:ElevatED/core/constants/app_colors.dart';
import 'package:ElevatED/core/constants/enum.dart';
import 'package:ElevatED/features/data/data%20sources/cache/memory_cache.dart';
import 'package:ElevatED/features/presentation/6_main/sub_screens/home/instructor_home.dart';
import 'package:ElevatED/features/presentation/6_main/sub_screens/courses/courses_screen.dart';
import 'package:ElevatED/features/presentation/6_main/sub_screens/home/student_home.dart';
import 'package:ElevatED/features/presentation/6_main/sub_screens/instructor_creativity/instructor_creativity_screen.dart';
import 'package:flutter_lazy_indexed_stack/flutter_lazy_indexed_stack.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';
import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ElevatED/features/presentation/6_main/sub_screens/profile/view/student_profile_screen.dart';
import 'package:ElevatED/features/presentation/6_main/sub_screens/profile/view/instructor_profile_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedIndex = 0;
  late final List<BarItem> barItems;
  late final List<Widget> pages;

  @override
  void initState() {
    super.initState();
    _initializeNavigation();
  }

  void _initializeNavigation() {
    final userData = MemoryCache.getUserData() ??
        MemoryCache.staticUserData(UserRoleEnum.student);

    switch (userData.role) {
      case UserRoleEnum.student:
        barItems = [
          BarItem(
            filledIcon: Icons.home_rounded,
            outlinedIcon: Icons.home_outlined,
          ),
          BarItem(
            filledIcon: CupertinoIcons.book_fill,
            outlinedIcon: CupertinoIcons.book,
          ),
          BarItem(
            filledIcon: Icons.person_rounded,
            outlinedIcon: Icons.person_outline_rounded,
          ),
        ];
        pages = [
          const StudentHome(),
          const CoursesScreen(),
          const StudentProfileScreen(),
        ];
        break;
      case UserRoleEnum.instructor:
        barItems = [
          BarItem(
            filledIcon: Icons.home_rounded,
            outlinedIcon: Icons.home_outlined,
          ),
          BarItem(
            filledIcon: CupertinoIcons.book_fill,
            outlinedIcon: CupertinoIcons.book,
          ),
          BarItem(
            filledIcon: Icons.school_rounded,
            outlinedIcon: Icons.school_outlined,
          ),
          BarItem(
            filledIcon: Icons.person_rounded,
            outlinedIcon: Icons.person_outline_rounded,
          ),
        ];
        pages = [
          const InstructorHome(),
          const CoursesScreen(),
          const InstructorCreativityScreen(),
          const InstructorProfileScreen(),
        ];
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ThemeColors.backgroundColor,
      body: LazyIndexedStack(
        index: selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: WaterDropNavBar(
        bottomPadding: 16.h,
        backgroundColor: ThemeColors.lightSurfaceToDarkSecondary,
        waterDropColor: AppColors.inversePrimaryColor,
        inactiveIconColor: ThemeColors.backgroundColor,
        selectedIndex: selectedIndex,
        barItems: barItems,
        onItemSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}
