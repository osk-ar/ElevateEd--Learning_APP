part of '../../cubit/video/video_player_ui_cubit.dart';

class VideoPlayerUIState extends Equatable {
  final bool isPlaying;
  final bool isMuted;
  final bool isFullScreen;
  final bool showControls;
  final Duration currentPosition;
  final Duration totalDuration;
  final double bufferProgress;

  const VideoPlayerUIState({
    this.isPlaying = false,
    this.isMuted = false,
    this.isFullScreen = false,
    this.showControls = true,
    this.currentPosition = Duration.zero,
    this.totalDuration = Duration.zero,
    this.bufferProgress = 0.0,
  });

  VideoPlayerUIState copyWith({
    bool? isPlaying,
    bool? isMuted,
    bool? isFullScreen,
    bool? showControls,
    Duration? currentPosition,
    Duration? totalDuration,
    double? bufferProgress,
  }) {
    return VideoPlayerUIState(
      isPlaying: isPlaying ?? this.isPlaying,
      isMuted: isMuted ?? this.isMuted,
      isFullScreen: isFullScreen ?? this.isFullScreen,
      showControls: showControls ?? this.showControls,
      currentPosition: currentPosition ?? this.currentPosition,
      totalDuration: totalDuration ?? this.totalDuration,
      bufferProgress: bufferProgress ?? this.bufferProgress,
    );
  }

  @override
  List<Object?> get props => [
        isPlaying,
        isMuted,
        isFullScreen,
        showControls,
        currentPosition,
        totalDuration,
        bufferProgress,
      ];
}
