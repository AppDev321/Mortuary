import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class ImageService {
  Future<File?> pickImage({ImageSource imageSource});

  Future<List<File>> pickMultipleImages();
}

class ImageServiceImpl implements ImageService {
  final _imagePicker = ImagePicker();

  ImageServiceImpl();

  /// There's a known issue for ios simulator, that the image picker opens twice for the first time after permissions are given
  /// https://github.com/flutter/flutter/issues/82602
  @override
  Future<File?> pickImage(
      {ImageSource imageSource = ImageSource.gallery}) async {
    XFile? pickedFile;

    var permission = Platform.isIOS
        ? Permission.photosAddOnly
        : imageSource == ImageSource.camera
            ? Permission.camera
            : Permission.storage;

    final PermissionStatus status = await permission.status;

    // if (status == PermissionStatus.granted) {
    pickedFile = await _imagePicker.pickImage(source: imageSource);

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final croppedFile = await _cropImage(pickedFile);
      if (croppedFile != null) {
        return croppedFile;
      }
      return file;
    }
    // } else if (status == PermissionStatus.denied) {
    //   final requestedStatus = await permission.request();
    //   if (requestedStatus == PermissionStatus.permanentlyDenied) {
    //     await getErrorDialog(
    //         GeneralError(
    //             title: 'Permission Denied',
    //             message: 'Please provide Storage Permissions'),
    //         buttonText: 'Open Settings', onPressed: () async {
    //       await openAppSettings();
    //       Get.back();
    //     });
    //   } else if (requestedStatus == PermissionStatus.granted) {
    //     return await pickImage(imageSource: imageSource);
    //   }
    // }

    return null;
  }

  @override
  Future<List<File>> pickMultipleImages() async {
    List<XFile> pickedFiles = [];

    const permission = Permission.storage;
    final PermissionStatus status = await permission.status;

    if (status == PermissionStatus.granted) {
      pickedFiles = await _imagePicker.pickMultiImage();

      return pickedFiles.map((pickedFile) => File(pickedFile.path)).toList();
    } else if (status == PermissionStatus.denied ||
        status == PermissionStatus.restricted) {
      await permission.request();
      await pickMultipleImages();
      // return Future.error();
    }

    return pickedFiles.map((pickedFile) => File(pickedFile.path)).toList();
  }

  Future<File?> _cropImage(XFile pickedFile) async {
    final croppedImage = await ImageCropper().cropImage(
        sourcePath: File(pickedFile.path).path,
        maxWidth: 1080,
        maxHeight: 1080,
        aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          )
        ]);
    if (croppedImage != null) {
      return File(croppedImage.path);
    }
    return null;
  }
}
