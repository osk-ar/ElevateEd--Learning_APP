part of 'package:ElevatED/features/presentation/6_main/cubits/stats_cubit.dart';

class StatsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class StatsInitial extends StatsState {}

class StatsLoaded extends StatsState {
  final List<DataPoint> activityPoints;
  StatsLoaded(this.activityPoints);

  @override
  List<Object?> get props => [activityPoints];
}

class StatsError extends StatsState {
  final String message;
  StatsError(this.message);

  @override
  List<Object?> get props => [message];
}
