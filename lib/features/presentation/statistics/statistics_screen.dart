import 'dart:math';

import 'package:ElevatED/core/constants/enum.dart';
import 'package:ElevatED/features/presentation/statistics/widgets/progress_chart.dart';
import 'package:ElevatED/features/presentation/common/layouts/default_layout.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
//progress Screen

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

Map<DateTime, double> generateRandomMap(int count, double min, double max) {
  final DateTime startDate = DateTime(2021, 4, 1); // 1 to 7 so 0 to 6 in points
  final Random random = Random();
  Map<DateTime, double> data = {};

  for (int i = 0; i < count; i++) {
    DateTime date = startDate.add(Duration(days: i));
    double value = min + random.nextDouble() * (max - min);
    data[date] = value;
  }
  print(data.keys.last);

  return data;
}

Map<DateTime, double> generateRandomYearMap(int count, double min, double max) {
  final DateTime startDate = DateTime(2021, 1, 1); // 1 to 7 so 0 to 6 in points
  final Random random = Random();
  Map<DateTime, double> data = {};

  for (int i = 0; i < count; i++) {
    // Add one month while handling overflow
    DateTime date =
        DateTime(startDate.year, startDate.month + i, startDate.day);
    double value = min + random.nextDouble() * (max - min);
    data[date] = value;
  }
  print(data.keys.last);

  return data;
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  late Map<DateTime, double> rawWeekData;
  late Map<DateTime, double> rawMonthData;
  late Map<DateTime, double> rawYearData;
  Map<DateTime, double> getRawData(int index) {
    switch (index) {
      case 0:
        return rawWeekData;
      case 1:
        return rawMonthData;
      case 2:
        return rawYearData;
      default:
        return {};
    }
  }

  @override
  void initState() {
    rawWeekData = generateRandomMap(7, 2, 7);
    rawMonthData = generateRandomMap(30, 2, 7);
    rawYearData = generateRandomYearMap(12, 30, 120);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      topPadding: 0,
      bottomPadding: 0,
      leftPadding: 16,
      rightPadding: 16,
      scrollable: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 24.h),
          SizedBox(
            height: 330.h,
            child: PageView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                controller: PageController(initialPage: 1, keepPage: true),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return ProgressChart(
                    rawData: getRawData(index),
                    chartDurationType: ProgressCharType.values[index],
                  );
                }),
          ),
          SizedBox(height: 24.h),
          const Text(
            "My courses",
            style: TextStyle(fontSize: 30),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildTabButton('All Courses', true, () {}),
              _buildTabButton('On Going', false, () {}),
              _buildTabButton('Finished', false, () {}),
            ],
          ),
          const SizedBox(height: 16),
          _buildCourseCard(
            'Product Design Expert Class',
            'Let’s continue learning journey to enhance skills.',
          ),
          _buildCourseCard(
            'Web Design Beginner Class',
            'Start your journey to master web design basics.',
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Widget _buildTabButton(String text, bool isActive, Function()? onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: isActive ? Colors.blue : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildCourseCard(String title, String subtitle) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.play_circle_fill,
                  color: Colors.blue, size: 40),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
