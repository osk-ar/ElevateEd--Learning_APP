import 'package:e_learning_app_gp/features/presentation/courses/screen/courses_screen.dart';
import 'package:e_learning_app_gp/features/presentation/profile/screen/profile_screen.dart';
import 'package:e_learning_app_gp/features/presentation/statistics/statistics_screen.dart';
import 'package:e_learning_app_gp/features/presentation/home/screen/home_screen.dart';
import 'package:e_learning_app_gp/core/resources/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';
import 'package:e_learning_app_gp/config/themes/theme.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController pageController = PageController();
  int selectedIndex = 0;
  List<BarItem> barItems = [
    BarItem(
      filledIcon: Icons.home_rounded,
      outlinedIcon: Icons.home_outlined,
    ),
    BarItem(
      filledIcon: CupertinoIcons.book_fill,
      outlinedIcon: CupertinoIcons.book,
    ),
    BarItem(
      filledIcon: Icons.data_usage_rounded,
      outlinedIcon: Icons.data_usage_rounded,
    ),
    BarItem(
      filledIcon: Icons.person_rounded,
      outlinedIcon: Icons.person_outline_rounded,
    ),
  ];
  List<Widget> pages = const [
    HomeScreen(),
    CoursesScreen(),
    StatisticsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: MyTheme.backgroundColor,
      appBar: getAppBar(context, selectedIndex),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: pages,
      ),
      bottomNavigationBar: WaterDropNavBar(
        bottomPadding: 16.h,
        backgroundColor: MyTheme.surfaceColor,
        waterDropColor: MyTheme.primaryColor,
        inactiveIconColor: MyTheme.onSurfaceColor,
        selectedIndex: selectedIndex,
        barItems: barItems,
        onItemSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
          pageController.animateToPage(selectedIndex,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutQuad);
        },
      ),
    );
  }

  PreferredSizeWidget? getAppBar(BuildContext context, int selectedIndex) {
    switch (selectedIndex) {
      case 1:
        return _getCoursesAppBar;
      case 2:
        return _getStatsAppBar;
      case 3:
        return _getProfileAppBar;
      default:
        return null;
    }
  }

  PreferredSizeWidget? get _getStatsAppBar {
    return AppBar(
      backgroundColor: MyTheme.backgroundColor,
      elevation: 0,
      title: Text("Progress",
          style: AppTextStyles.mediumTextStyle(context, fontSize: 24)),
      centerTitle: true,
      leading: const SizedBox(),
    );
  }

  PreferredSizeWidget? get _getProfileAppBar {
    return AppBar(
      backgroundColor: MyTheme.backgroundColor,
      elevation: 0,
      title: Text("Profile",
          style: AppTextStyles.mediumTextStyle(context, fontSize: 24)),
      centerTitle: true,
      leading: const SizedBox(),
    );
  }

  PreferredSizeWidget? get _getCoursesAppBar {
    //TODO add filter & search functionality
    return AppBar(
      elevation: 0,
      centerTitle: true,
      leading: const SizedBox(),
      backgroundColor: MyTheme.backgroundColor,
      title: Text(
        "Courses",
        style: AppTextStyles.mediumTextStyle(context, fontSize: 24),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.filter_list_rounded,
            color: MyTheme.textColor,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.search_rounded,
            color: MyTheme.textColor,
          ),
        ),
      ],
    );
  }
}
