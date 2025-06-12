import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:ElevatED/config/themes/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExpandableText extends StatefulWidget {
  const ExpandableText({
    super.key,
    required this.text,
  });

  final String text;

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  int size = 3;

  @override
  Widget build(BuildContext context) {
    print("building: $size");
    return InkWell(
      onTap: () {
        setState(() {
          size == 3 ? size = 10 : size = 3;
        });
      },
      child: Text(
        maxLines: size,
        softWrap: true,
        widget.text,
        overflow: TextOverflow.ellipsis,
        style: getLightStyle(fontSize: 14.sp, color: ThemeColors.textColor),
      ),
    );
  }
}
