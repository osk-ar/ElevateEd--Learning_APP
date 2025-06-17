import 'dart:async';
import 'dart:io';
import 'package:ElevatED/config/extensions.dart';
import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:ElevatED/core/constants/app_colors.dart';
import 'package:ElevatED/features/presentation/course_content_play/cubit/video/video_comments_cubit.dart';
import 'package:ElevatED/features/presentation/course_content_play/cubit/video/video_streaming_cubit.dart';
import 'package:ElevatED/features/presentation/course_content_play/cubit/video/video_player_ui_cubit.dart';
import 'package:ElevatED/features/presentation/course_content_play/screens/widgets/comment_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ElevatED/config/themes/text_styles.dart';
import 'package:ElevatED/features/domain/usecases/send_activity_point_usecase.dart';
import 'package:ElevatED/features/data/data sources/cache/memory_cache.dart';
import 'package:ElevatED/init.dart';

class CourseVideoScreen extends StatefulWidget {
  const CourseVideoScreen({super.key});

  @override
  State<CourseVideoScreen> createState() => _CourseVideoScreenState();
}

class _CourseVideoScreenState extends State<CourseVideoScreen> {
  late VideoPlayerController _playerController;
  static const double _defaultAspectRatio = 16 / 9;
  Timer? _hideControlsTimer;
  final TextEditingController _commentController = TextEditingController();
  Timer? _timeSpentTimer;
  int _secondsSpent = 0;
  // Colors for shimmer effect
  static const _shimmerBaseColor = ThemeColors.lightSurfaceToDarkSecondary;
  static const _shimmerHighlightColor = ThemeColors.backgroundColor;

  @override
  void initState() {
    super.initState();
    _playerController = VideoPlayerController.file(File(''));
    _setupVideoController();
    context.read<VideoStreamingCubit>().initialize(loadComments: (videoUrl) {
      context.read<VideoCommentsCubit>().loadComments(videoUrl);
    });
    _timeSpentTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      _secondsSpent++;
    });
  }

  void _setupVideoController() {
    _playerController.addListener(() {
      final uiCubit = context.read<VideoPlayerUICubit>();
      uiCubit.updatePosition(_playerController.value.position);
      uiCubit.updateDuration(_playerController.value.duration);
      // Safely compute buffer progress – the buffered list may be empty
      double progress = 0.0;
      if (_playerController.value.buffered.isNotEmpty &&
          _playerController.value.duration.inMilliseconds > 0) {
        progress = _playerController.value.buffered.last.end.inMilliseconds /
            _playerController.value.duration.inMilliseconds;
      }
      uiCubit.updateBufferProgress(progress);
    });
  }

  void _startHideControlsTimer() {
    _hideControlsTimer?.cancel();
    _hideControlsTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        context.read<VideoPlayerUICubit>().hideControls();
      }
    });
  }

  void _handleTap() {
    final uiCubit = context.read<VideoPlayerUICubit>();
    if (uiCubit.state.showControls) {
      uiCubit.hideControls();
    } else {
      uiCubit.showControls();
      _startHideControlsTimer();
    }
  }

  @override
  void dispose() {
    _hideControlsTimer?.cancel();
    _playerController.pause();
    _playerController.dispose();
    _timeSpentTimer?.cancel();
    context.read<VideoStreamingCubit>().sendActivityPoint(_secondsSpent);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  Widget _buildShimmerBox({required double height, BorderRadius? radius}) {
    return Shimmer.fromColors(
      baseColor: _shimmerBaseColor,
      highlightColor: _shimmerHighlightColor,
      child: Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: _shimmerBaseColor,
          borderRadius: radius ?? BorderRadius.circular(4),
        ),
      ),
    );
  }

  // Shimmer layout displayed while the video or comments are loading
  Widget _buildLoadingShimmer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Video placeholder (16:9)
        AspectRatio(
          aspectRatio: _defaultAspectRatio,
          child: _buildShimmerBox(height: double.infinity),
        ),
        const SizedBox(height: 12),
        // Comments title placeholder
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: _buildShimmerBox(height: 20, radius: BorderRadius.circular(2)),
        ),
        const SizedBox(height: 8),
        // Comments list placeholders
        Expanded(
          child: ListView.separated(
            itemCount: 6,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Avatar circle
                    Shimmer.fromColors(
                      baseColor: _shimmerBaseColor,
                      highlightColor: _shimmerHighlightColor,
                      child: const CircleAvatar(
                          radius: 16, backgroundColor: _shimmerBaseColor),
                    ),
                    const SizedBox(width: 12),
                    // Comment body
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildShimmerBox(height: 14),
                          const SizedBox(height: 6),
                          _buildShimmerBox(
                              height: 14, radius: BorderRadius.circular(2)),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<VideoStreamingCubit, VideoStreamingState>(
          listener: (context, state) {
            if (state is VideoStreamingReady) {
              _playerController = VideoPlayerController.file(state.videoFile);
              _setupVideoController();
              _playerController.initialize().then((_) {
                context
                    .read<VideoPlayerUICubit>()
                    .updateDuration(_playerController.value.duration);
                context
                    .read<VideoStreamingCubit>()
                    .attachController(_playerController);
                context.read<VideoPlayerUICubit>().showControls();
                _startHideControlsTimer();
              });
            } else if (state is VideoStreamingError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
        ),
        BlocListener<VideoPlayerUICubit, VideoPlayerUIState>(
          listener: (context, state) {
            if (state.isFullScreen) {
              SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.landscapeLeft,
                DeviceOrientation.landscapeRight,
              ]);
            } else {
              SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
              SystemChrome.setPreferredOrientations(
                  [DeviceOrientation.portraitUp]);
            }
          },
        ),
      ],
      child: BlocBuilder<VideoStreamingCubit, VideoStreamingState>(
        builder: (context, streamingState) {
          Widget body;
          if (streamingState is VideoStreamingInitial ||
              streamingState is VideoStreamingLoading) {
            body = _buildLoadingShimmer();
          } else if (streamingState is VideoStreamingError) {
            body = Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  SizedBox(height: 16.h),
                  Text(streamingState.message),
                ],
              ),
            );
          } else if (streamingState is VideoStreamingReady ||
              streamingState is VideoStreamingBuffering) {
            body = BlocBuilder<VideoPlayerUICubit, VideoPlayerUIState>(
              builder: (context, uiState) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (!uiState.isFullScreen) ...[
                      AppBar(
                        backgroundColor:
                            ThemeColors.lightSurfaceToDarkSecondary,
                        surfaceTintColor: Colors.transparent,
                      ),
                    ],
                    Expanded(
                      child: GestureDetector(
                        onTap: _handleTap,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            AspectRatio(
                              aspectRatio: _playerController.value.aspectRatio,
                              child: VideoPlayer(_playerController),
                            ),
                            if (uiState.showControls)
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      ThemeColors.backgroundColor
                                          .withAlpha(155),
                                      Colors.transparent,
                                      Colors.transparent,
                                      ThemeColors.backgroundColor
                                          .withAlpha(155),
                                    ],
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    if (uiState.showControls)
                                      Container(
                                        color: ThemeColors
                                            .lightSurfaceToDarkSecondary,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            VideoProgressIndicator(
                                              _playerController,
                                              allowScrubbing: true,
                                              colors: VideoProgressColors(
                                                playedColor:
                                                    AppColors.primaryColor,
                                                bufferedColor: AppColors
                                                    .inversePrimaryColor
                                                    .withAlpha(100),
                                                backgroundColor: Colors.grey,
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    IconButton(
                                                      onPressed: () {
                                                        context
                                                            .read<
                                                                VideoStreamingCubit>()
                                                            .togglePlayPause();
                                                        context
                                                            .read<
                                                                VideoPlayerUICubit>()
                                                            .togglePlayPause();
                                                      },
                                                      icon: Icon(
                                                        uiState.isPlaying
                                                            ? Icons
                                                                .pause_rounded
                                                            : Icons.play_arrow,
                                                        color: AppColors
                                                            .primaryColor,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 8.w,
                                                    ),
                                                    IconButton(
                                                      onPressed: () {
                                                        context
                                                            .read<
                                                                VideoStreamingCubit>()
                                                            .toggleMute();
                                                        context
                                                            .read<
                                                                VideoPlayerUICubit>()
                                                            .toggleMute();
                                                      },
                                                      icon: Icon(
                                                        uiState.isMuted
                                                            ? Icons.volume_off
                                                            : Icons.volume_up,
                                                        color: AppColors
                                                            .primaryColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                IconButton(
                                                  onPressed: () => context
                                                      .read<
                                                          VideoPlayerUICubit>()
                                                      .toggleFullScreen(),
                                                  icon: Icon(
                                                    uiState.isFullScreen
                                                        ? Icons.fullscreen_exit
                                                        : Icons.fullscreen,
                                                    color:
                                                        AppColors.primaryColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    if (!uiState.isFullScreen) ...[
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 10.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 110.w,
                              child: ElevatedButton(
                                onPressed: context
                                        .read<VideoStreamingCubit>()
                                        .canNavigatePrevious()
                                    ? () => context
                                        .read<VideoStreamingCubit>()
                                        .navigateToPrevious()
                                    : () => context.message(
                                          message: "This is the first video",
                                        ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      ThemeColors.lightSurfaceToDarkSecondary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                ),
                                child: Text(
                                  "Previous",
                                  style: getMediumStyle(
                                      fontSize: 14.sp,
                                      color: ThemeColors.textColor),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 110.w,
                              child: ElevatedButton(
                                onPressed: context
                                        .read<VideoStreamingCubit>()
                                        .canNavigateNext()
                                    ? () => context
                                        .read<VideoStreamingCubit>()
                                        .navigateToNext()
                                    : () => context.message(
                                          message: "You Reached The End !",
                                        ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      AppColors.inversePrimaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  "Next",
                                  style: getMediumStyle(
                                      fontSize: 14.sp,
                                      color: ThemeColors.inverseTextColor),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      BlocBuilder<VideoCommentsCubit, VideoCommentsState>(
                        builder: (context, state) {
                          if (state is VideoCommentsLoading ||
                              state is VideoCommentsInitial) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (state is VideoCommentsError) {
                            return Center(
                              child: Text(state.message),
                            );
                          }
                          return Expanded(
                            child: CommentSection(
                              comments: state is VideoCommentsLoaded
                                  ? state.comments
                                  : [],
                            ),
                          );
                        },
                      ),
                      Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: ThemeColors.backgroundColor,
                          boxShadow: [
                            BoxShadow(
                              color: ThemeColors.lightSurfaceToDarkSecondary
                                  .withAlpha(26),
                              blurRadius: 4.r,
                              offset: Offset(0, -2.w),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _commentController,
                                decoration: InputDecoration(
                                  hintText: 'Add a comment...',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.r),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor:
                                      ThemeColors.lightSurfaceToDarkSecondary,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                    vertical: 8.h,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            IconButton(
                              onPressed: () {
                                context.read<VideoCommentsCubit>().addComment(
                                    context
                                        .read<VideoStreamingCubit>()
                                        .currentVideoUrl,
                                    _commentController.text);
                                _commentController.clear();
                              },
                              icon: const Icon(Icons.send),
                              color: AppColors.primaryColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                );
              },
            );
          } else {
            body = const Center(child: Text('Unknown state'));
          }

          return Scaffold(
            backgroundColor: ThemeColors.backgroundColor,
            body: body,
          );
        },
      ),
    );
  }
}
