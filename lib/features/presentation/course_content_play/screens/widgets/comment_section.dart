import 'package:ElevatED/config/themes/text_styles.dart';
import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:ElevatED/features/data/models/video/comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommentSection extends StatelessWidget {
  const CommentSection({super.key, required this.comments});
  final List<Comment> comments;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(8.0.r),
            itemCount: comments.length,
            itemBuilder: (context, index) {
              final comment = comments[index];
              final date = comment.date?.split('T')[0];
              final time = comment.date?.split('T')[1];

              return Padding(
                padding: EdgeInsets.only(bottom: 8.0.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(radius: 5.r, backgroundColor: Colors.teal),
                        SizedBox(width: 5.w),
                        Text(
                          "${comments[index].userName} • $date • ${time?.split(':')[0]}:${time?.split(':')[1]}",
                          style: TextStyle(
                              fontSize: 12.sp, color: ThemeColors.textColor),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Container(
                      padding: EdgeInsets.all(12.r),
                      margin: EdgeInsets.only(left: 16.w),
                      decoration: BoxDecoration(
                        color: ThemeColors.lightSurfaceToDarkSecondary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        comment.text,
                        style: getMediumStyle(
                            fontSize: 14.sp, color: ThemeColors.textColor),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
