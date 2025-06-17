import 'dart:developer';

import 'package:ElevatED/features/data/data%20sources/cache/memory_cache.dart';
import 'package:ElevatED/features/domain/usecases/add_comment_usecase.dart';
import 'package:ElevatED/features/domain/usecases/get_comments_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ElevatED/features/data/models/video/comment.dart';

part '../../state/video/video_comments_state.dart';

class VideoCommentsCubit extends Cubit<VideoCommentsState> {
  final GetCommentsUseCase getCommentsUseCase;
  final AddCommentUseCase addCommentUseCase;
  List<Comment> comments = [];

  VideoCommentsCubit(this.getCommentsUseCase, this.addCommentUseCase)
      : super(const VideoCommentsInitial());

  Future<void> loadComments(String videoUrl) async {
    try {
      emit(const VideoCommentsLoading());
      final comments = await getCommentsUseCase.call(videoUrl);
      this.comments = comments;
      emit(VideoCommentsLoaded(comments: comments));
    } catch (e) {
      emit(VideoCommentsError(message: e.toString()));
    }
  }

  Future<void> addComment(String videoUrl, String content) async {
    try {
      await addCommentUseCase.call(videoUrl, content);
      final newComment = Comment(
          id: 0,
          text: content,
          userName: MemoryCache.getUserData()!.name,
          date:
              "${DateTime.now().toString().split(' ')[0]}T${DateTime.now().toString().split(' ')[1]}");

      comments.add(newComment);
      emit(VideoCommentsLoaded(comments: comments));
    } catch (e) {
      emit(VideoCommentsError(message: e.toString()));
    }
  }

  Future<void> refreshComments(String videoId) async {
    await loadComments(videoId);
  }
}
