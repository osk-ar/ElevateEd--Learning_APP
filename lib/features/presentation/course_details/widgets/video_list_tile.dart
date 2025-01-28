import 'package:e_learning_app_gp/core/resources/app_styles.dart';
import 'package:e_learning_app_gp/config/themes/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class VideoListTile extends StatelessWidget {
  const VideoListTile({
    super.key,
    required this.title,
    required this.duration,
    required this.onTap,
  });
  final void Function() onTap;
  final String title;
  final String duration;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
      tileColor: MyTheme.secondaryColor,
      leading: const CircleAvatar(
        backgroundColor: MyTheme.primaryColor,
        child: Icon(Icons.play_arrow),
      ),
      title: Text(
        title,
        style: getLightStyle(fontSize: 14.sp, color: MyTheme.textColor),
      ),
      trailing: Text(
        duration,
        style: getRegularStyle(fontSize: 14.sp, color: MyTheme.textColor),
      ),
    );
  }
}


/*
Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: MyTheme.primaryColor,
            ),
            child: const Center(
              child: Icon(Icons.play_arrow),
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
              ),
              const SizedBox(height: 4),
              Text(
                duration,
              ),
            ],
          ),
        ],
      ),
    );
 */