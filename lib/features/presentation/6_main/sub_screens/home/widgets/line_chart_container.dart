import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:ElevatED/core/constants/app_colors.dart';
import 'package:ElevatED/core/constants/enum.dart';
import 'package:ElevatED/config/themes/text_styles.dart';
import 'package:ElevatED/features/presentation/6_main/sub_screens/home/widgets/line_chart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LineChartContainer extends StatefulWidget {
  const LineChartContainer(
      {super.key, required this.chartRange, required this.rawData});
  final Map<DateTime, double> rawData;
  final ChartRangeEnum chartRange;

  @override
  State<LineChartContainer> createState() => _LineChartContainerState();
}

class _LineChartContainerState extends State<LineChartContainer> {
  late int pointCount;
  late List<FlSpot> spots;
  late FlSpot maxValuePoint;
  late Map<int, String> leftTitlesMap;
  late Map<int, String> bottomTitlesMap;
  @override
  void initState() {
    Map<DateTime, double> dataToUse = widget.rawData;
    if (widget.rawData.isEmpty) {
      // Generate zero values based on chart range
      dataToUse = _generateZeroValues(widget.chartRange);
    }

    pointCount = widget.chartRange != ChartRangeEnum.month
        ? dataToUse.length
        : getMonthLength(dataToUse.keys.first);
    switch (widget.chartRange) {
      case ChartRangeEnum.week:
        spots = reduceWeekDataToFLSpots(data: dataToUse);
        break;
      case ChartRangeEnum.month:
        spots =
            reduceMonthDataToFLSpots(data: dataToUse, pointCount: pointCount);
        break;
      case ChartRangeEnum.year:
        spots = reduceYearDataToFLSpots(data: dataToUse);
        break;
    }
    maxValuePoint = spots.reduce((a, b) {
      var valueA = a.y;
      var valueB = b.y;
      return valueA > valueB ? a : b;
    });
    leftTitlesMap =
        _getLeftTitlesText(pointCount: pointCount, maxValue: maxValuePoint.y);
    bottomTitlesMap = _getBottomTitlesText(pointCount: pointCount);
    super.initState();
  }

  Map<DateTime, double> _generateZeroValues(ChartRangeEnum range) {
    final now = DateTime.now();
    Map<DateTime, double> zeroValues = {};

    switch (range) {
      case ChartRangeEnum.week:
        // Generate zero values for the last 7 days
        for (int i = 6; i >= 0; i--) {
          final date = now.subtract(Duration(days: i));
          zeroValues[date] = 0;
        }
        break;
      case ChartRangeEnum.month:
        // Generate zero values for the current month
        final daysInMonth = getMonthLength(now);
        for (int i = 1; i <= daysInMonth; i++) {
          final date = DateTime(now.year, now.month, i);
          zeroValues[date] = 0;
        }
        break;
      case ChartRangeEnum.year:
        // Generate zero values for each month of the current year
        for (int i = 1; i <= 12; i++) {
          final date = DateTime(now.year, i, 1);
          zeroValues[date] = 0;
        }
        break;
    }
    return zeroValues;
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: ThemeColors.lightSurfaceToDarkSecondary,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          SizedBox(height: 16.h),
          Text(
            widget.chartRange.name.toUpperCase(),
            style: getMediumStyle(fontSize: 16, color: AppColors.whiteColor),
          ),
          Expanded(
            child: CustomLineChart(
              bottomTitleWidgets: (value, meta) =>
                  _bottomTitleWidgets(value, meta, bottomTitlesMap),
              leftTitleWidgets: (value, meta) =>
                  _leftTitleWidgets(value, meta, leftTitlesMap),
              xAxisMinMax: [0, pointCount - 1],
              yAxisMinMax: [
                0,
                widget.chartRange == ChartRangeEnum.year
                    ? (maxValuePoint.y).round()
                    : 10
              ],
              spots: spots,
            ),
          ),
        ],
      ),
    );
  }

  Map<int, String> _getBottomTitlesText({required int pointCount}) {
    switch (pointCount) {
      case 7:
        return {
          0: 'Mon',
          1: 'Tue',
          2: 'Wed',
          3: 'Thu',
          4: 'Fri',
          5: 'Sat',
          6: 'Sun',
        };
      case > 12:
        return {
          0: '1',
          5: '6',
          11: '12',
          17: '18',
          23: '24',
          29: '30',
        };
      case 12:
        return {
          0: 'Jan',
          2: 'Mar',
          4: 'May',
          6: 'Jul',
          8: 'Sep',
          10: 'Nov',
        };

      default:
        return {};
    }
  }

  Map<int, String> _getLeftTitlesText(
      {required int pointCount, double? maxValue}) {
    // If we have a maxValue, calculate dynamic points
    if (maxValue != null && maxValue > 0) {
      // For small values (less than 16), use steps of 4
      if (maxValue <= 16) {
        final step = 4.0;
        final points = <int, String>{};
        for (double i = 0; i <= maxValue; i += step) {
          points[i.round()] = i.round().toString();
        }
        return points;
      }

      // For larger values, calculate 4 evenly distributed points
      final step =
          maxValue / 3; // This gives us 4 points (0, step, 2*step, maxValue)
      return {
        0: '0',
        step.round(): '${step.round()}',
        (step * 2).round(): '${(step * 2).round()}',
        maxValue.round(): '${maxValue.round()}',
      };
    }

    // Fallback for when maxValue is 0 or null - use default steps of 4
    return {
      0: '0',
      4: '4',
      8: '8',
      12: '12',
    };
  }

  Widget _bottomTitleWidgets(
      double value, TitleMeta meta, Map<int, String> bottomTitlesMap) {
    Widget title;
    if (bottomTitlesMap.keys.contains(value.toInt())) {
      title = Text(
        bottomTitlesMap[value.toInt()]!,
        style: getRegularStyle(fontSize: 14.sp, color: AppColors.whiteColor),
      );
    } else {
      title = Container();
    }

    return SideTitleWidget(
      axisSide: AxisSide.bottom,
      child: title,
    );
  }

  Widget _leftTitleWidgets(
      double value, TitleMeta meta, Map<int, String> leftTitlesMap) {
    Widget title;
    if (leftTitlesMap.keys.contains(value.toInt())) {
      title = Text(
        leftTitlesMap[value.toInt()]!,
        style: getRegularStyle(fontSize: 14.sp, color: AppColors.whiteColor),
      );
    } else {
      title = Container();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: title,
    );
  }
}

//*--------------Testing Generator & Padding Data--------------------

Map<int, double> padDataNulls(Map<int, double> data, int size) {
  for (int i = 1; i <= size; i++) {
    if (data.containsKey(i)) {
      continue;
    }

    data.addEntries([MapEntry(i, 0)]);
  }
  return data;
}

//*---------------Week Functions-------------------

Map<int, double> mapWeekDataTimeToPositions(Map<DateTime, double> data) {
  Map<int, double> weekData = {};
  data.forEach((key, value) {
    weekData[key.weekday] = value;
  });
  return weekData;
}

List<FlSpot> reduceWeekDataToFLSpots({required Map<DateTime, double> data}) {
  List<FlSpot> spots = [];
  Map<int, double> modifiedData = mapWeekDataTimeToPositions(data);
  padDataNulls(modifiedData, 7);

  modifiedData.forEach((key, value) {
    spots.add(FlSpot(key.toDouble() - 1, value));
  });
  spots.sort((a, b) => a.x.compareTo(b.x));

  return spots;
}

//*---------------Month Functions-------------------

Map<int, double> mapMonthDataTimeToPositions(Map<DateTime, double> data) {
  Map<int, double> monthData = {};
  data.forEach((key, value) {
    monthData[key.day] = value;
  });
  return monthData;
}

List<FlSpot> reduceMonthDataToFLSpots(
    {required Map<DateTime, double> data, required int pointCount}) {
  List<FlSpot> spots = [];
  Map<int, double> modifiedData = mapMonthDataTimeToPositions(data);
  padDataNulls(modifiedData, pointCount);

  modifiedData.forEach((key, value) {
    spots.add(FlSpot(key.toDouble() - 1, value));
  });
  spots.sort((a, b) => a.x.compareTo(b.x));

  return spots;
}

int getMonthLength(DateTime date) {
  var year = date.year;
  var month = date.month;
  bool isMoonMonth = false;
  if (year % 4 == 0) {
    isMoonMonth = true;
  }
  if (month == 2) {
    return isMoonMonth ? 28 : 29;
  }
  switch (month) {
    case 1:
    case 3:
    case 5:
    case 7:
    case 8:
    case 10:
    case 12:
      return 31;

    case 4:
    case 6:
    case 9:
    case 11:
      return 30;

    default:
      return 30;
  }
}

//*---------------Year Functions-------------------

Map<int, double> mapYearDataTimeToPositions(Map<DateTime, double> data) {
  // 12 point
  Map<int, double> yearData = {};
  data.forEach((key, value) {
    yearData[key.month] = value;
  });
  return yearData;
}

List<FlSpot> reduceYearDataToFLSpots({required Map<DateTime, double> data}) {
  // 12 point
  List<FlSpot> spots = [];
  Map<int, double> modifiedData = mapYearDataTimeToPositions(data);
  padDataNulls(modifiedData, 12);

  modifiedData.forEach((key, value) {
    spots.add(FlSpot(key.toDouble() - 1, value));
  });
  spots.sort((a, b) => a.x.compareTo(b.x));
  return spots;
}
