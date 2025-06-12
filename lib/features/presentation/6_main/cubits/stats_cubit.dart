import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ElevatED/features/data/data%20sources/cache/memory_cache.dart';
import 'package:ElevatED/features/data/models/data_point.dart';
import 'package:ElevatED/features/data/models/user_data.dart';

part 'package:ElevatED/features/presentation/6_main/states/stats_state.dart';

class StatsCubit extends Cubit<StatsState> {
  StatsCubit() : super(StatsInitial());

  void loadUserActivityPoints() {
    final user = MemoryCache.getUserData();
    switch (user) {
      case StudentUserData():
        emit(StatsLoaded(user.activityPoints));
        break;
      case InstructorUserData():
        emit(StatsLoaded(user.revenuePoints));
    }
  }

  Map<DateTime, double> getRawData(List<DataPoint> points, int index) {
    final now = DateTime.now();
    switch (index) {
      case 0: // week
        final weekAgo = now.subtract(const Duration(days: 6));
        return {
          for (final p in points)
            if (p.dateTime.isAfter(weekAgo) &&
                p.dateTime.isBefore(now.add(const Duration(days: 1))))
              DateTime(p.dateTime.year, p.dateTime.month, p.dateTime.day):
                  p.value
        };
      case 1: // month
        final monthAgo = DateTime(now.year, now.month, 1);
        return {
          for (final p in points)
            if (p.dateTime
                    .isAfter(monthAgo.subtract(const Duration(days: 1))) &&
                p.dateTime.isBefore(now.add(const Duration(days: 1))))
              DateTime(p.dateTime.year, p.dateTime.month, p.dateTime.day):
                  p.value
        };
      case 2: // year
        // Aggregate by month, sum values for each month
        Map<int, double> monthSums = {};
        for (final p in points) {
          if (p.dateTime.year == now.year) {
            final month = p.dateTime.month;
            monthSums[month] = (monthSums[month] ?? 0) + p.value;
          }
        }
        // Create a map with DateTime for each month (1st day) and the sum
        return {
          for (int m = 1; m <= 12; m++)
            DateTime(now.year, m, 1): monthSums[m] ?? 0
        };
      default:
        return {};
    }
  }
}
