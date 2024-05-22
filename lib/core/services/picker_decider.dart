import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'file_picker_service.dart';
import 'image_service.dart';

enum FileSource { deviceFiles, photoGallery, camera }

abstract class FileChooserService {
  Future<File?> chooseFile({FileSource source});
  Future<List<File>?> chooseMultipleFiles({FileSource source});
}

class FileChooserServiceImpl implements FileChooserService {
  final ImageService _imageService = ImageServiceImpl();
  final FilePickerService _filePickerService = FilePickerServiceImpl();

  @override
  Future<File?> chooseFile({FileSource source = FileSource.deviceFiles}) async {
    File? file;
    switch (source) {
      case FileSource.deviceFiles:
        file = await _filePickerService.pickFile();
        break;
      case FileSource.photoGallery:
        file = await _imageService.pickImage(imageSource: ImageSource.gallery);

        break;
      case FileSource.camera:
        file = await _imageService.pickImage(imageSource: ImageSource.camera);
        break;
    }
    return file;
  }

  @override
  Future<List<File>?> chooseMultipleFiles(
      {FileSource source = FileSource.deviceFiles}) async {
    List<File>? files;
    switch (source) {
      case FileSource.deviceFiles:
        files = await _filePickerService.pickMultipleFiles();
        break;
      case FileSource.photoGallery:
      case FileSource.camera:
        files = await _imageService.pickMultipleImages();
        break;
    }
    return files;
  }
}
