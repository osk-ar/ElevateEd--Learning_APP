part of '../../cubit/video/video_comments_cubit.dart';

abstract class VideoCommentsState {
  const VideoCommentsState();
}

class VideoCommentsInitial extends VideoCommentsState {
  const VideoCommentsInitial();
}

class VideoCommentsLoading extends VideoCommentsState {
  const VideoCommentsLoading();
}

class VideoCommentsLoaded extends VideoCommentsState {
  final List<Comment> comments;

  const VideoCommentsLoaded({required this.comments});
}

class VideoCommentsError extends VideoCommentsState {
  final String message;

  const VideoCommentsError({required this.message});
}
