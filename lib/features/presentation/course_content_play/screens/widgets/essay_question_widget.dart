import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:ElevatED/config/themes/text_styles.dart';
import 'package:ElevatED/features/data/models/assignment/question.dart';
import 'package:ElevatED/features/presentation/0_common/input_field.dart';
import 'package:ElevatED/core/constants/app_strings.dart';

class EssayQuestionWidget extends StatelessWidget {
  final EssayQuestion question;
  final String answer;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  const EssayQuestionWidget({
    super.key,
    required this.question,
    required this.answer,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ThemeColors.lightSurfaceToDarkSecondary,
      margin: EdgeInsets.symmetric(vertical: 8.h),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question.title,
              style:
                  getMediumStyle(fontSize: 16.sp, color: ThemeColors.textColor),
            ),
            SizedBox(height: 8.h),
            InputField(
              minLines: 2,
              maxLines: 5,
              title: AppStrings.assignmentSolverEssayPlaceholder,
              controller: controller,
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}

class EssayController {
  final TextEditingController controller;
  final int index;
  EssayController({required this.controller, required this.index});

  void dispose() {
    controller.dispose();
  }
}
