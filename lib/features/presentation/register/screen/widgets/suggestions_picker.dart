import 'package:e_learning_app_gp/config/themes/theme.dart';
import 'package:e_learning_app_gp/core/constants/enum.dart';
import 'package:e_learning_app_gp/core/resources/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SuggestionsWidget extends StatefulWidget {
  const SuggestionsWidget(
      {super.key,
      required this.editSuggestions,
      required this.suggestionSelected,
      required this.getSelectedSuggestionTextColor});
  final void Function(Interests item) editSuggestions;
  final bool Function(Interests item) suggestionSelected;
  final Color Function(Interests item) getSelectedSuggestionTextColor;

  @override
  State<SuggestionsWidget> createState() => _SuggestionsWidgetState();
}

class _SuggestionsWidgetState extends State<SuggestionsWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0.r),
      child: Container(
        padding: EdgeInsets.all(16.r),
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF2889FB), width: 1),
          borderRadius: BorderRadius.circular(16.r),
          color: MyTheme.surfaceColor,
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
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: widget.suggestionSelected(topic)
                      ? MyTheme.primaryColor
                      : MyTheme.onSurfaceColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  topic.name,
                  style: AppTextStyles.regularTextStyle(
                    context,
                    fontSize: 14.sp,
                    color: widget.getSelectedSuggestionTextColor(topic),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
