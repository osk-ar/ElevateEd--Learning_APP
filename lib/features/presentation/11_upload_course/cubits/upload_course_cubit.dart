import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ElevatED/features/data/models/upload/upload_course_model.dart';
import 'package:ElevatED/features/presentation/11_upload_course/screen/widgets/upload_item_widget.dart';
import 'package:ElevatED/features/data/models/video/upload_video_initialize.dart';
import 'package:ElevatED/features/data/models/video/video_chunk_model.dart';
import 'package:ElevatED/features/domain/repositories/app_repository.dart';

class UploadCourseCubit extends Cubit<UploadCourseState> {
  final AppRepository repo;
  UploadCourseCubit(this.repo) : super(UploadCourseInitial());
  late final int courseID;

  Future<void> startUpload(UploadCourseModel courseModel) async {
    try {
      await _startUploadInternal(courseModel);
    } catch (e) {
      emit(UploadCourseError(e.toString()));
    }
  }

  Future<void> _startUploadInternal(UploadCourseModel courseModel) async {
    final steps = <UplaodItemProperities>[
      UplaodItemProperities('Course Details', 0),
    ];
    for (var i = 0; i < courseModel.assignments.length; i++) {
      steps.add(UplaodItemProperities(
        'Assignment - ${courseModel.assignments[i].title}',
        i + steps.length,
      ));
    }
    for (var i = 0; i < courseModel.videos.length; i++) {
      steps.add(UplaodItemProperities(
        'Video - ${courseModel.videos[i].title}',
        i + steps.length,
      ));
    }
    emit(UploadCourseProgress(List<UplaodItemProperities>.from(steps)));

    // Step 1: Upload course details
    steps[0].status = UploadStatus.loading;
    emit(UploadCourseProgress(List<UplaodItemProperities>.from(steps)));
    courseID = await repo.uploadCourseDetails(courseModel);
    steps[0].status = UploadStatus.finished;
    steps[0].progress = 100;
    emit(UploadCourseProgress(List<UplaodItemProperities>.from(steps)));

    // Step 2: Upload assignments
    for (var i = 0; i < courseModel.assignments.length; i++) {
      steps[i + 1].status = UploadStatus.loading;
      emit(UploadCourseProgress(List<UplaodItemProperities>.from(steps)));
      await repo.uploadCourseAssignment(courseModel.assignments[i], courseID);
      steps[i + 1].status = UploadStatus.finished;
      steps[i + 1].progress = 100;
      emit(UploadCourseProgress(List<UplaodItemProperities>.from(steps)));
    }

    // Step 3: Upload videos one by one with chunked upload
    for (int i = 0; i < courseModel.videos.length; i++) {
      final idx = i + courseModel.assignments.length + 1;
      steps[idx].status = UploadStatus.loading;
      steps[idx].progress = 0;
      emit(UploadCourseProgress(List<UplaodItemProperities>.from(steps)));
      final video = courseModel.videos[i];
      final file = File(video.path);
      final fileSize = await file.length();
      const chunkSize = 1024 * 1024 * 2; // 2MB
      final chunksCount = (fileSize / chunkSize).ceil();
      final uploadInitModel = UploadVideoInitializeModel(
        video.title,
        fileSize,
        chunksCount,
        courseID,
      );
      final uploadId = await repo.uploadVideoInitialize(uploadInitModel);
      for (int chunkIdx = 0; chunkIdx < chunksCount; chunkIdx++) {
        final start = chunkIdx * chunkSize;
        final end = ((chunkIdx + 1) * chunkSize < fileSize)
            ? (chunkIdx + 1) * chunkSize
            : fileSize;
        final chunkFile = await _createChunkFile(file, start, end, chunkIdx);
        final chunkModel = VideoChunkModel(
          uploadID: uploadId,
          file: chunkFile,
          chunkIndex: chunkIdx,
        );
        await repo.uploadVideoChunk(chunkModel);
        steps[idx].progress = ((chunkIdx + 1) / chunksCount) * 100;
        emit(UploadCourseProgress(List<UplaodItemProperities>.from(steps)));
        await chunkFile.delete();
      }
      await repo.uploadVideoFinalize(uploadId);
      steps[idx].status = UploadStatus.finished;
      emit(UploadCourseProgress(List<UplaodItemProperities>.from(steps)));
    }

    // step 4 navigate to course details screen
    emit(UploadCourseSuccess());
  }

  Future<File> _createChunkFile(
      File file, int start, int end, int chunkIdx) async {
    final raf = file.openSync();
    raf.setPositionSync(start);
    final chunk = raf.readSync(end - start);
    raf.closeSync();
    final tempDir = Directory.systemTemp;
    final chunkFile = File('${tempDir.path}/chunk_$chunkIdx.tmp');
    await chunkFile.writeAsBytes(chunk);
    return chunkFile;
  }
}

abstract class UploadCourseState {}

class UploadCourseInitial extends UploadCourseState {}

class UploadCourseProgress extends UploadCourseState {
  final List<UplaodItemProperities> steps;
  UploadCourseProgress(this.steps);
}

class UploadCourseSuccess extends UploadCourseState {}

class UploadCourseError extends UploadCourseState {
  final String message;
  UploadCourseError(this.message);
}
