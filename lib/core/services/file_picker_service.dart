import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:mortuary/core/error/errors.dart';
import 'package:mortuary/core/popups/show_popups.dart';

abstract class FilePickerService {
  Future<File?> pickFile();

  Future<List<File>> pickMultipleFiles();

  Future removeAllFiles();

  Future<File> saveBytesAsFile(Uint8List bodyBytes, String extension);
}

class FilePickerServiceImpl implements FilePickerService {
  final _filePicker = FilePicker.platform;
  FilePickerServiceImpl();

  @override
  Future<File?> pickFile() async {
    File? pickedFile;

    // https://github.com/Baseflow/flutter-permission-handler/issues/568#issuecomment-849494650
    const permission = Permission.storage;
    final PermissionStatus status = await permission.status;

    if (status == PermissionStatus.granted) {
      FilePickerResult? result = await _filePicker.pickFiles(
        allowMultiple: false,
      );

      if (result != null) {
        pickedFile = File(result.files.first.path!);
      }
      return pickedFile;
    } else if (status == PermissionStatus.denied) {
      final status = await permission.request();
      if (status == PermissionStatus.permanentlyDenied) {
        getErrorDialog(
            GeneralError(
                title: 'Permission Denied',
                message: 'Please provide Storage Permissions'),
            buttonText: 'Open Settings', onPressed: () async {
          await openAppSettings();
          Get.back();
        });
      } else if (status == PermissionStatus.granted) {
        await pickFile();
      }
      // return Future.error();
    }

    return null;
  }

  @override
  Future<List<File>> pickMultipleFiles() async {
    List<File> pickedFiles = [];

    const permission = Permission.storage;
    final PermissionStatus status = await permission.status;

    if (status == PermissionStatus.granted) {
      FilePickerResult? result =
          await _filePicker.pickFiles(allowMultiple: true);

      if (result != null) {
        pickedFiles = result.paths.map((path) => File(path!)).toList();
      }
      return pickedFiles;
    } else if (status == PermissionStatus.denied ||
        status == PermissionStatus.restricted) {
      await permission.request();
      await pickMultipleFiles();
      // return Future.error();
    }

    return pickedFiles;
  }

  @override
  Future<File> saveBytesAsFile(Uint8List bodyBytes, String extension) async {
    final Directory? appDir = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    final Directory imagesDirectory =
        await Directory("${appDir!.path}/images").create(recursive: true);

    // imagesDirectory.create();

    String tempPath = imagesDirectory.path;
    final String fileName =
        '${DateTime.now().microsecondsSinceEpoch}.$extension';
    File file = File('$tempPath/$fileName');
    if (!await file.exists()) {
      await file.create();
    }
    await file.writeAsBytes(bodyBytes);
    return file;
  }

  @override
  Future removeAllFiles() async {
    final Directory? appDir = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    final targetSubDirectory = Directory("${appDir!.path}/images");

    if (targetSubDirectory.existsSync()) {
      for (var files in await targetSubDirectory.list().toList()) {
        if (files.existsSync()) {
          files.deleteSync();
        }
      }
    }
  }
}
