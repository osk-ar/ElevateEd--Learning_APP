import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ElevatED/core/services/Media%20Picker%20Services/media_picker_service.dart';
import 'package:ElevatED/features/data/models/view/normalized_course_content.dart';
import 'package:ElevatED/features/presentation/10_create_course/states/content_states.dart';

class ContentCubit extends Cubit<ContentState> {
  List<NormalizedCourseContent> _content = [];
  final MediaPickerService _mediaPickerService;

  ContentCubit(this._mediaPickerService) : super(ContentInitial());

  List<NormalizedCourseContent> get content => List.unmodifiable(_content);

  Future<UploadCourseVideo?> pickVideo(BuildContext context) async {
    try {
      final videoFile = await _mediaPickerService.pickSingle();
      if (videoFile == null) return null;

      final List<String> fullName = videoFile.path.split('/').last.split(".");
      final String title = fullName.first;
      final String extension = fullName.last;

      final video = UploadCourseVideo(
        index: _content.length,
        title: title,
        path: videoFile.path,
        extension: extension,
      );

      return video;
    } catch (e) {
      emit(ContentError(e.toString(), _content));
      return null;
    }
  }

  Future<void> pickMultipleVideos(BuildContext context) async {
    try {
      final videoFiles = await _mediaPickerService.pickMultiple();
      if (videoFiles.isEmpty) return;

      final newContent = [..._content];
      for (var videoFile in videoFiles) {
        final List<String> fullName = videoFile.path.split('/').last.split(".");
        final String title = fullName.first;
        final String extension = fullName.last;

        newContent.add(UploadCourseVideo(
          index: newContent.length,
          title: title,
          path: videoFile.path,
          extension: extension,
        ));
      }
      _content = newContent;
      emit(ContentUpdated(_content));
    } catch (e) {
      emit(ContentError(e.toString(), _content));
    }
  }

  void addContent(NormalizedCourseContent? item) {
    if (item == null) return;

    final newContent = [..._content, item];
    log(newContent.length.toString());
    log(_content.length.toString());
    _content = newContent;
    emit(ContentUpdated(_content));
  }

  void removeContent(int index) {
    if (index < 0 || index >= _content.length) return;

    _content.removeAt(index);
    updateIndices();
    emit(ContentItemRemoved(_content, index));
  }

  void reorderContent(int oldIndex, int newIndex) {
    // --- Standard Guards and Index Correction ---
    if (oldIndex < 0 || oldIndex >= _content.length || newIndex < 0) {
      return;
    }
    // Adjust the newIndex if the item is moved down the list.
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    if (newIndex >= _content.length) return;
    // ---------------------------------------------

    // 1. Reorder the list
    final item = _content.removeAt(oldIndex);
    _content.insert(newIndex, item);

    // 2. Loop through the reordered list and update the internal index of each item
    updateIndices();

    emit(ContentReordered(_content, oldIndex, newIndex));
  }

  void resetContent() {
    _content = [];
    emit(ContentInitial());
  }

  void updateIndices() {
    for (int i = 0; i < _content.length; i++) {
      _content[i] = _content[i].copyWith(index: i);
    }
  }
}
