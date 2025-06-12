import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:ElevatED/core/constants/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomLineChart extends StatelessWidget {
  const CustomLineChart(
      {super.key,
      required this.leftTitleWidgets,
      required this.bottomTitleWidgets,
      required this.xAxisMinMax,
      required this.yAxisMinMax,
      required this.spots});
  final Widget Function(double value, TitleMeta meta) leftTitleWidgets;
  final Widget Function(double value, TitleMeta meta) bottomTitleWidgets;
  final List<int> xAxisMinMax;
  final List<int> yAxisMinMax;
  final List<FlSpot> spots;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Padding(
        padding: EdgeInsets.only(
          right: 16.w,
          left: 8.w,
          top: 24.h,
          bottom: 12.h,
        ),
        child: LineChart(getCharData),
      ),
    );
  }

  LineChartData get getCharData {
    return LineChartData(
      lineTouchData: const LineTouchData(
        enabled: false,
      ),
      gridData: FlGridData(
        checkToShowHorizontalLine: (value) {
          if (yAxisMinMax[1] < 16) {
            return true;
          }
          int max = yAxisMinMax[1] - 1;
          List<int> validPoints = [];
          int p0 = yAxisMinMax[0] + 1;
          int p1 = (max / 4).round();
          int p2 = (max / 2).round();
          int p3 = (max * (3 / 4)).round();
          int p4 = max;
          validPoints.addAll([p0, p1, p2, p3, p4]);
          int val = value.round();

          if (validPoints.contains(val)) {
            return true;
          }
          return false;
        },
        checkToShowVerticalLine: (value) {
          if (xAxisMinMax[1] < 16) {
            return true;
          }
          int min = xAxisMinMax[0] + 1;
          int max = xAxisMinMax[1] - 1;
          List<int> validPoints = [];
          int p0 = min;
          int p1 = (max / 4).round();
          int p2 = (max / 2).round();
          int p3 = (max * (3 / 4)).round();
          int p4 = max;
          validPoints.addAll([p0, p1, p2, p3, p4]);
          int val = value.round();

          if (validPoints.contains(val)) {
            return true;
          }
          return false;
        },
        show: true,
        drawVerticalLine: true,
        drawHorizontalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: AppColors.primaryColor,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: AppColors.primaryColor,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: ThemeColors.backgroundColor),
      ),
      minX: xAxisMinMax[0].toDouble(),
      maxX: xAxisMinMax[1].toDouble(),
      minY: yAxisMinMax[0].toDouble(),
      maxY: yAxisMinMax[1].toDouble(),
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          curveSmoothness: 0.3,
          barWidth: 5,
          isStrokeCapRound: true,
          color: AppColors.inversePrimaryColor,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            color: AppColors.inversePrimaryColor.withAlpha(76),
          ),
        ),
      ],
    );
  }
}
