import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part '../../state/video/video_player_ui_state.dart';

class VideoPlayerUICubit extends Cubit<VideoPlayerUIState> {
  VideoPlayerUICubit() : super(const VideoPlayerUIState());

  void togglePlayPause() {
    emit(state.copyWith(isPlaying: !state.isPlaying));
  }

  void toggleMute() {
    emit(state.copyWith(isMuted: !state.isMuted));
  }

  void toggleFullScreen() {
    emit(state.copyWith(isFullScreen: !state.isFullScreen));
  }

  void updatePosition(Duration position) {
    emit(state.copyWith(currentPosition: position));
  }

  void updateDuration(Duration duration) {
    emit(state.copyWith(totalDuration: duration));
  }

  void updateBufferProgress(double progress) {
    emit(state.copyWith(bufferProgress: progress));
  }

  void showControls() {
    emit(state.copyWith(showControls: true));
  }

  void hideControls() {
    emit(state.copyWith(showControls: false));
  }

  void reset() {
    emit(const VideoPlayerUIState());
  }
}
