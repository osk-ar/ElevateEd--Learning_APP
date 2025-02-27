import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:ElevatED/core/constants/enum.dart';
import 'package:ElevatED/core/resources/app_colors.dart';
import 'package:ElevatED/core/resources/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SuggestionsWidget extends StatefulWidget {
  const SuggestionsWidget({
    super.key,
    required this.editSuggestions,
    required this.suggestionSelected,
  });
  final void Function(Interests item) editSuggestions;
  final bool Function(Interests item) suggestionSelected;

  @override
  State<SuggestionsWidget> createState() => _SuggestionsWidgetState();
}

class _SuggestionsWidgetState extends State<SuggestionsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      margin: EdgeInsets.symmetric(horizontal: 30.w),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.onSurfaceColor, width: 2.w),
        borderRadius: BorderRadius.circular(10.r),
        color: ThemeColors.secondaryColor,
      ),
      child: Wrap(
        spacing: 8.w, // Horizontal spacing between containers
        runSpacing: 8.h, // Vertical spacing between rows
        children: Interests.values.map((topic) {
          return InkWell(
            borderRadius: BorderRadius.circular(12.r),
            onTap: () {
              setState(() {
                widget.editSuggestions(topic);
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
              decoration: BoxDecoration(
                  color: widget.suggestionSelected(topic)
                      ? AppColors.primaryColor
                      : ThemeColors.backgroundColor,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                      width: 1,
                      strokeAlign: BorderSide.strokeAlignOutside,
                      color: AppColors.primaryColor)),
              child: Text(
                topic.name,
                style: getRegularStyle(
                  fontSize: 14.sp,
                  color: widget.suggestionSelected(topic)
                      ? ThemeColors.inverseTextColor
                      : AppColors.primaryColor,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
