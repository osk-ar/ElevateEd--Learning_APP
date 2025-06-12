import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'package:ElevatED/features/presentation/under_shit/course_video_state.dart';

class CourseVideoCubit extends Cubit<CourseVideoState> {
  CourseVideoCubit() : super(const CourseVideoState());

  void togglePlayPause() {
    emit(state.copyWith(isPaused: !state.isPaused));
  }

  void toggleMute() {
    emit(state.copyWith(isMuted: !state.isMuted));
  }

  void updateSlider(double value) {
    emit(state.copyWith(sliderValue: value));
  }
}
