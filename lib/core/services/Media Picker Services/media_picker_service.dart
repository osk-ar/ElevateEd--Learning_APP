import 'dart:io';
import 'package:ElevatED/core/constants/enum.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

// Base interface for all picker services
abstract interface class IPickerService {
  Future<File?> pickSingle({List<String>? allowedExtensions});
  Future<List<File>> pickMultiple({List<String>? allowedExtensions});
  Future<File> renameItem(File item, String newName);
  Future<String> getStorageDirectory();
}

// Abstract base class with common functionality
abstract class BasePickerService implements IPickerService {
  @override
  Future<String> getStorageDirectory() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  @override
  Future<File> renameItem(File item, String newName) async {
    try {
      final directory = await getStorageDirectory();
      final fileExtension = item.path.split('.').last;
      final newFilePath = '$directory/$newName.$fileExtension';

      final newFile = await _getUniqueFileName(File(newFilePath));
      return await item.rename(newFile.path);
    } catch (e) {
      throw FileSystemException('Failed to rename item: $e');
    }
  }

  Future<File> _getUniqueFileName(File file) async {
    String filePath = file.path;
    String baseName = filePath.split('.').first;
    String extension = filePath.split('.').last;
    int counter = 1;

    while (await file.exists()) {
      filePath = '$baseName($counter).$extension';
      file = File(filePath);
      counter++;
    }

    return file;
  }
}

// File Picker Service implementation
class FilePickerService extends BasePickerService {
  static FilePickerService? _instance;

  FilePickerService._();

  static FilePickerService getInstance() {
    _instance ??= FilePickerService._();
    return _instance!;
  }

  @override
  Future<File?> pickSingle({List<String>? allowedExtensions}) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: allowedExtensions,
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        return File(result.files.single.path!);
      }
      return null;
    } catch (e) {
      print('Error picking file: $e');
      return null;
    }
  }

  @override
  Future<List<File>> pickMultiple({List<String>? allowedExtensions}) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: allowedExtensions,
        allowMultiple: true,
      );

      if (result != null && result.files.isNotEmpty) {
        return result.files.map((file) => File(file.path!)).toList();
      }
      return [];
    } catch (e) {
      print('Error picking multiple files: $e');
      return [];
    }
  }
}

// Video Picker Service implementation
class VideoPickerService extends BasePickerService {
  static VideoPickerService? _instance;

  VideoPickerService._();

  static VideoPickerService getInstance() {
    _instance ??= VideoPickerService._();
    return _instance!;
  }

  static const _videoExtensions = ['mp4', 'mov', 'avi', 'mkv'];

  @override
  Future<File?> pickSingle({List<String>? allowedExtensions}) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: allowedExtensions ?? _videoExtensions,
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        return File(result.files.single.path!);
      }
      return null;
    } catch (e) {
      print('Error picking video: $e');
      return null;
    }
  }

  @override
  Future<List<File>> pickMultiple({List<String>? allowedExtensions}) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: allowedExtensions ?? _videoExtensions,
        allowMultiple: true,
      );

      if (result != null && result.files.isNotEmpty) {
        return result.files.map((file) => File(file.path!)).toList();
      }
      return [];
    } catch (e) {
      print('Error picking multiple videos: $e');
      return [];
    }
  }
}

// Image Picker Service implementation
class ImagePickerService extends BasePickerService {
  static ImagePickerService? _instance;

  ImagePickerService._();

  static ImagePickerService getInstance() {
    _instance ??= ImagePickerService._();
    return _instance!;
  }

  static const _imageExtensions = ['jpg', 'jpeg', 'png', 'gif'];

  @override
  Future<File?> pickSingle({List<String>? allowedExtensions}) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: allowedExtensions ?? _imageExtensions,
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        return File(result.files.single.path!);
      }
      return null;
    } catch (e) {
      print('Error picking image: $e');
      return null;
    }
  }

  @override
  Future<List<File>> pickMultiple({List<String>? allowedExtensions}) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: allowedExtensions ?? _imageExtensions,
        allowMultiple: true,
      );

      if (result != null && result.files.isNotEmpty) {
        return result.files.map((file) => File(file.path!)).toList();
      }
      return [];
    } catch (e) {
      print('Error picking multiple images: $e');
      return [];
    }
  }
}

// Factory class with picking methods
class MediaPickerService {
  final IPickerService _pickerService;

  MediaPickerService._(this._pickerService);

  factory MediaPickerService.create(MediaType type) {
    switch (type) {
      case MediaType.file:
        return MediaPickerService._(FilePickerService.getInstance());
      case MediaType.video:
        return MediaPickerService._(VideoPickerService.getInstance());
      case MediaType.image:
        return MediaPickerService._(ImagePickerService.getInstance());
    }
  }

  Future<File?> pickSingle({List<String>? allowedExtensions}) async {
    return await _pickerService.pickSingle(
        allowedExtensions: allowedExtensions);
  }

  Future<List<File>> pickMultiple({List<String>? allowedExtensions}) async {
    return await _pickerService.pickMultiple(
        allowedExtensions: allowedExtensions);
  }

  Future<File> renameItem(File item, String newName) async {
    return await _pickerService.renameItem(item, newName);
  }
}
