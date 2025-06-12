import 'package:ElevatED/config/themes/text_styles.dart';
import 'package:ElevatED/core/constants/app_colors.dart';
import 'package:ElevatED/core/services/Language%20Service/language_service.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBarChart extends StatelessWidget {
  const CustomBarChart(
      {super.key,
      required this.titleHeight,
      required this.titlesTopMargin,
      required this.toolTipMargin,
      required this.barData,
      this.width,
      this.radius});
  final double titleHeight;
  final double titlesTopMargin;
  final double toolTipMargin;
  final List<double> barData;
  final double? width;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: barTouchData(context),
        titlesData: titlesData,
        borderData: borderData,
        barGroups: barGroups(context),
        gridData: const FlGridData(show: false),
        alignment: BarChartAlignment.spaceAround,
        maxY:
            barData.isEmpty ? 0 : barData.reduce((a, b) => a > b ? a : b) + 2.h,
      ),
    );
  }

  BarTouchData barTouchData(BuildContext context) => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipRoundedRadius: 12.r,
          tooltipHorizontalAlignment: FLHorizontalAlignment.center,
          getTooltipColor: (group) => Colors.transparent,
          tooltipPadding: EdgeInsets.symmetric(
            horizontal: 12.w,
          ),
          tooltipMargin: toolTipMargin,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            final TextDirection textDirection =
                LanguageService.getTextDirection(context);

            final lastIndex =
                textDirection == TextDirection.ltr ? barData.length - 1 : 0;

            return BarTooltipItem(
              (rod.toY - 1).round().toString(),
              getBoldStyle(
                fontSize: 12.sp,
                color: groupIndex == lastIndex
                    ? AppColors.inversePrimaryColor
                    : AppColors.whiteColor,
              ),
            );
          },
        ),
      );

  FlTitlesData get titlesData => const FlTitlesData(show: false);

  FlBorderData get borderData => FlBorderData(show: false);

  List<BarChartGroupData> barGroups(BuildContext context) =>
      List<BarChartGroupData>.generate(
        barData.length,
        (index) {
          final TextDirection textDirection =
              LanguageService.getTextDirection(context);

          final data = textDirection == TextDirection.ltr
              ? barData
              : barData.reversed.toList();

          return BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                toY: data[index],
                color: AppColors.primaryColor,
                width: width,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(radius ?? 20.r),
                  topLeft: Radius.circular(1.r),
                  bottomLeft: Radius.circular(1.r),
                  bottomRight: Radius.circular(1.r),
                ),
              ),
            ],
            showingTooltipIndicators: [0],
          );
        },
      );
}
