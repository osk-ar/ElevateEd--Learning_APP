import 'package:e_learning_app_gp/config/themes/theme.dart';
import 'package:e_learning_app_gp/core/resources/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Hello, ",
                style:
                    getMediumStyle(fontSize: 16.sp, color: MyTheme.textColor),
              ),
              TextSpan(
                text: "$name\n",
                style: getMediumStyle(
                    fontSize: 16.sp, color: MyTheme.primaryColor),
              ),
              TextSpan(
                text: "Lets Learn Now!",
                style:
                    getSemiBoldStyle(fontSize: 24.sp, color: MyTheme.textColor)
                        .copyWith(height: 1.5.sp),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_outlined),
              style:
                  IconButton.styleFrom(backgroundColor: MyTheme.secondaryColor),
            ),
          ],
        )
      ],
    );
  }
}
