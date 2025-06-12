part of 'package:ElevatED/features/presentation/under_shit/course_video_cubit.dart';

class CourseVideoState extends Equatable {
  final bool isPaused;
  final bool isMuted;
  final double sliderValue;

  const CourseVideoState({
    this.isPaused = true,
    this.isMuted = true,
    this.sliderValue = 0.5,
  });

  CourseVideoState copyWith(
      {bool? isPaused, bool? isMuted, double? sliderValue}) {
    return CourseVideoState(
      isPaused: isPaused ?? this.isPaused,
      isMuted: isMuted ?? this.isMuted,
      sliderValue: sliderValue ?? this.sliderValue,
    );
  }

  @override
  List<Object?> get props => [];
}
