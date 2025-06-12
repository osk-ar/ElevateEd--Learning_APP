import 'dart:developer';
import 'dart:io';
import 'package:ElevatED/core/constants/enum.dart';
import 'package:ElevatED/core/services/Media%20Picker%20Services/media_picker_service.dart';
import 'package:ElevatED/core/services/image%20services/image_services.dart';
import 'package:ElevatED/features/data/models/upload/upload_course_model.dart';
import 'package:ElevatED/features/data/models/view/normalized_course_content.dart';
import 'package:ElevatED/features/data/models/assignment/question.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ElevatED/features/domain/repositories/app_repository.dart';
import 'package:ElevatED/features/data/models/course/course_category.dart';
part 'package:ElevatED/features/presentation/10_create_course/cubit/create_course_state.dart';

class CreateCourseCubit extends Cubit<CreateCourseState> {
  final ImageServices _imageServices;
  final MediaPickerService _mediaPickerService =
      MediaPickerService.create(MediaType.video);
  final AppRepository appRepository;
  CreateCourseCubit(this._imageServices, this.appRepository)
      : super(CreateCourseInit()) {
    fetchCategories();
  }
  int currentIndex = 0;
  List<NormalizedCourseContent> courseContent = [];
  List<Question> lastAssignmentQuestions = [];
  int categoryID = 0;
  UploadCourseModel? finalCourseModel;

  // Category state
  List<CourseCategory> categories = [];
  bool isCategoriesLoading = false;
  String? categoriesError;

  Future<void> fetchCategories() async {
    isCategoriesLoading = true;
    categoriesError = null;
    emit(CreateCourseCategoriesLoading());
    try {
      categories = await appRepository.getCategories();
      isCategoriesLoading = false;
      emit(CreateCourseCategoriesLoaded(categories, categoryID));
    } catch (e) {
      isCategoriesLoading = false;
      categoriesError = e.toString();
      emit(CreateCourseCategoriesError(categoriesError!));
    }
  }

  void incrementIndex() {
    currentIndex = (currentIndex + 1).clamp(0, 2);
    log("increment");
    emit(CreateCourseNavigated(currentIndex));
  }

  void decrementIndex() {
    currentIndex = (currentIndex - 1).clamp(0, 2);
    log("decrement");
    emit(CreateCourseNavigated(currentIndex));
  }

  Future<File?> pickImage(BuildContext context) async {
    XFile? imageXFile = await _imageServices.pickImage();

    if (!context.mounted || imageXFile == null) return null;

    File? image = await _imageServices.cropImage(context, imageXFile.path);

    return image;
  }

  Future<UploadCourseVideo?> pickVideo(BuildContext context) async {
    File? videoFile = await _mediaPickerService.pickSingle();

    if (!context.mounted || videoFile == null) return null;

    final List<String> fullName = videoFile.path.split('/').last.split(".");
    final String title = fullName.first;
    final String extension = fullName.last;

    UploadCourseVideo video = UploadCourseVideo(
      index: courseContent.length,
      path: videoFile.path,
      title: title,
      extension: extension,
    );

    return video;
  }

  Future<void> pickMultipleVideos(BuildContext context) async {
    emit(CreateCourseContentLoading());
    List<File> videoFiles = await _mediaPickerService.pickMultiple();

    if (!context.mounted || videoFiles.isEmpty) {
      emit(CreateCourseContentUpdated(courseContent));
      return;
    }

    for (var videoFile in videoFiles) {
      final List<String> fullName = videoFile.path.split('/').last.split(".");
      final String title = fullName.first;
      final String extension = fullName.last;

      UploadCourseVideo video = UploadCourseVideo(
        index: courseContent.length,
        path: videoFile.path,
        title: title,
        extension: extension,
      );

      courseContent.add(video);
    }

    emit(CreateCourseContentUpdated(courseContent));
  }

  void saveItem(NormalizedCourseContent? item) {
    if (item == null) return;
    courseContent.add(item);
    emit(CreateCourseContentUpdated(courseContent));
  }

  void saveQuestion(Question? question) {
    if (question == null) return;
    lastAssignmentQuestions.add(question);
    emit(CreateCourseQuestionsUpdated(lastAssignmentQuestions));
  }

  void removeContentItem(int index) {
    List<NormalizedCourseContent> updatedContent = List.from(courseContent);
    updatedContent.removeAt(index);
    for (var i = 0; i < updatedContent.length; i++) {
      updatedContent[i].index = i;
    }

    courseContent = updatedContent;
    emit(CreateCourseContentUpdated(updatedContent));
  }

  void removeQuestion(int index) {
    List<Question> updatedContent = List.from(lastAssignmentQuestions);
    updatedContent.removeAt(index);
    for (var i = 0; i < updatedContent.length; i++) {
      updatedContent[i].index = i;
    }

    lastAssignmentQuestions = updatedContent;
    emit(CreateCourseQuestionsUpdated(updatedContent));
  }

  void reOrderContent(int oldIndex, int newIndex) {
    final List<NormalizedCourseContent> updatedContent =
        List.from(courseContent);

    if (newIndex > oldIndex) {
      newIndex -= 1;
    }

    final movedItem = updatedContent.removeAt(oldIndex);
    updatedContent.insert(newIndex, movedItem);

    for (var i = 0; i < updatedContent.length; i++) {
      updatedContent[i].index = i;
    }

    courseContent = updatedContent;
    emit(CreateCourseContentUpdated(updatedContent));
  }

  void reOrderQuestions(int oldIndex, int newIndex) {
    final List<Question> updatedContent = List.from(lastAssignmentQuestions);

    if (newIndex > oldIndex) {
      newIndex -= 1;
    }

    final movedItem = updatedContent.removeAt(oldIndex);
    updatedContent.insert(newIndex, movedItem);

    for (var i = 0; i < updatedContent.length; i++) {
      updatedContent[i].index = i;
    }

    lastAssignmentQuestions = updatedContent;
    emit(CreateCourseQuestionsUpdated(updatedContent));
  }

  void resetContent() {
    currentIndex = 0;
    courseContent = [];

    emit(CreateCourseNavigated(currentIndex));
  }

  void resetQuestions() {
    lastAssignmentQuestions = [];
  }

  void changeCategory(int? newCategoryID) {
    categoryID = newCategoryID!;
    emit(CreateCourseCategoryChanged(categoryID));
  }
}
