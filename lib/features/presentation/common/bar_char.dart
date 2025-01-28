import 'package:e_learning_app_gp/config/themes/theme.dart';
import 'package:e_learning_app_gp/core/resources/app_styles.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBarChart extends StatelessWidget {
  const CustomBarChart(
      {super.key,
      required this.titleHeight,
      required this.titlesBarSpacer,
      required this.toolTipMargin,
      required this.barData,
      required this.titles,
      this.width,
      this.radius});
  final double titleHeight;
  final double titlesBarSpacer;
  final double toolTipMargin;
  final List<double> barData;
  final List<String> titles;
  final double? width;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300.h,
      width: double.infinity,
      child: BarChart(
        BarChartData(
          barTouchData: barTouchData,
          titlesData: titlesData,
          borderData: borderData,
          barGroups: barGroups,
          gridData: const FlGridData(show: false),
          alignment: BarChartAlignment.spaceAround,
          maxY: barData.reduce((a, b) => a > b ? a : b) + 2.h,
        ),
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (group) => Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: toolTipMargin,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                color: MyTheme.brighterPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    return SideTitleWidget(
      axisSide: AxisSide.bottom,
      space: titlesBarSpacer,
      child: Text(
        titles[value.toInt()],
        style: getBoldStyle(
          fontSize: 14.sp,
          color: MyTheme.darkerPrimaryColor,
        ),
      ),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: titleHeight,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(show: false);

  List<BarChartGroupData> get barGroups => List.generate(
        barData.length,
        (index) => BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
                toY: barData[index],
                gradient: _barsGradient,
                width: width,
                borderRadius: BorderRadius.circular(radius ?? 20)),
          ],
          showingTooltipIndicators: [0],
        ),
      );
}

LinearGradient get _barsGradient => const LinearGradient(
      colors: [
        MyTheme.darkerPrimaryColor,
        MyTheme.brighterPrimaryColor,
      ],
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
    );

// class BarChartSample3 extends StatefulWidget {
//   const BarChartSample3({super.key});

//   @override
//   State<StatefulWidget> createState() => BarChartSample3State();
// }

// class BarChartSample3State extends State<BarChartSample3> {
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 90.w,
//       height: 160.h,
//       child: CustomBarChart(
//         titleHeight: 20.h,
//         titlesBarSpacer: 4.h,
//         toolTipMargin: 4.h,
//         barData: const [5, 9, 3],
//         titles: const ["Th", "Fr", "Sa"],
//       ),
//     );
//   }
// }
