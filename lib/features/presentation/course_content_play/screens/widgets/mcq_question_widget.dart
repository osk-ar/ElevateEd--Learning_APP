import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:ElevatED/core/constants/app_colors.dart';
import 'package:ElevatED/config/themes/text_styles.dart';
import 'package:ElevatED/features/data/models/assignment/question.dart';

class McqQuestionWidget extends StatelessWidget {
  final MultipleChoiseQuestion question;
  final int? selected;
  final ValueChanged<int> onChanged;
  const McqQuestionWidget({
    Key? key,
    required this.question,
    required this.selected,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ThemeColors.lightSurfaceToDarkSecondary,
      margin: EdgeInsets.symmetric(vertical: 8.h),
      child: Padding(
        padding: EdgeInsets.all(12.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question.title,
              style:
                  getMediumStyle(fontSize: 16.sp, color: ThemeColors.textColor),
            ),
            ...List.generate(question.answers.length, (i) {
              final ans = question.answers[i];
              return RadioListTile<int>(
                value: i,
                groupValue: selected,
                onChanged: (val) => onChanged(val!),
                title: Text(
                  ans.text,
                  style: getRegularStyle(
                      fontSize: 15.sp, color: ThemeColors.textColor),
                ),
                activeColor: AppColors.primaryColor,
                contentPadding: EdgeInsets.zero,
              );
            }),
          ],
        ),
      ),
    );
  }
}
