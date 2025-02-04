import 'package:e_learning_app_gp/config/themes/theme.dart';
import 'package:e_learning_app_gp/core/constants/enum.dart';
import 'package:e_learning_app_gp/core/resources/app_styles.dart';
import 'package:e_learning_app_gp/core/resources/text_styles.dart';
import 'package:e_learning_app_gp/features/presentation/common/line_chart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProgressChart extends StatefulWidget {
  const ProgressChart(
      {super.key, required this.chartDurationType, required this.rawData});
  final Map<DateTime, double> rawData;
  final ProgressCharType chartDurationType;

  @override
  State<ProgressChart> createState() => _ProgressChartState();
}

class _ProgressChartState extends State<ProgressChart> {
  late int pointCount;
  late List<FlSpot> spots;
  late FlSpot maxValuePoint;
  late Map<int, String> leftTitlesMap;
  late Map<int, String> bottomTitlesMap;
  @override
  void initState() {
    pointCount = widget.chartDurationType != ProgressCharType.month
        ? widget.rawData.length
        : getMonthLength(widget.rawData.keys.first);
    switch (widget.chartDurationType) {
      case ProgressCharType.week:
        spots = reduceWeekDataToFLSpots(data: widget.rawData);
        break;
      case ProgressCharType.month:
        spots = reduceMonthDataToFLSpots(
            data: widget.rawData, pointCount: pointCount);
        break;
      case ProgressCharType.year:
        spots = reduceYearDataToFLSpots(data: widget.rawData);
        break;
      default:
        spots = [];
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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 330.h,
      margin: EdgeInsets.symmetric(horizontal: 2.w),
      decoration: BoxDecoration(
        color: MyTheme.surfaceColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 16.h,
          ),
          Text(
            widget.chartDurationType.name.toUpperCase(),
            style: AppTextStyles.mediumTextStyle(context, fontSize: 16),
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
                widget.chartDurationType == ProgressCharType.year
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
    switch (pointCount) {
      case 7:
      case > 12:
        return {
          1: '0h',
          3: '6h',
          5: '12h',
          7: '18h',
          9: '24h',
        };
      case 12:
        return {
          1: '0h',
          ((maxValue! / 4)).round(): '${(maxValue / 4).round()}h',
          ((maxValue / 2)).round(): '${(maxValue / 2).round()}h',
          ((maxValue * (3 / 4))).round(): '${(maxValue * (3 / 4)).round()}h',
          ((maxValue)).round(): '${maxValue.round()}h',
        };

      default:
        return {};
    }
  }

  Widget _bottomTitleWidgets(
      double value, TitleMeta meta, Map<int, String> bottomTitlesMap) {
    Widget title;
    if (bottomTitlesMap.keys.contains(value.toInt())) {
      title = Text(
        bottomTitlesMap[value.toInt()]!,
        style: getRegularStyle(fontSize: 14.sp, color: MyTheme.textColor),
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
        style: getRegularStyle(fontSize: 14.sp, color: MyTheme.textColor),
      );
    } else {
      title = Container();
    }

    return SideTitleWidget(
      axisSide: AxisSide.bottom,
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
