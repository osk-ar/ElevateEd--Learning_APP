import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_learning_app_gp/config/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InstructorListTile extends StatelessWidget {
  const InstructorListTile(
      {super.key,
      required this.imageUrl,
      required this.instructorName,
      required this.instructorProffesionalTitle,
      required this.onPressed});
  final String imageUrl;
  final String instructorName;
  final String instructorProffesionalTitle;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: MyTheme.secondaryColor,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(36.r),
      ),
      leading: CircleAvatar(
        radius: 25.r, // Size of the avatar
        backgroundImage: CachedNetworkImageProvider(imageUrl),
      ),
      title: Text(
        instructorName,
        style: const TextStyle(fontSize: 16),
      ),
      subtitle: Text(
        instructorProffesionalTitle,
        style: const TextStyle(fontSize: 12),
      ),
      trailing: IconButton(
        style: IconButton.styleFrom(
          backgroundColor: MyTheme.surfaceColor,
        ),
        onPressed: onPressed,
        icon: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
