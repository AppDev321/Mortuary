import 'dart:core';

import 'package:dio/dio.dart';
import '../../../../core/constants/app_urls.dart';
import '../../../../core/network/api_manager.dart';

abstract class UploadFileRemoteDataSource {
  Future<Map<String, dynamic>> uploadImageFile(
      {required String bandCodeId, required List<String> attachmentList});
}

class UploadFileRemoteDataSourceImpl implements UploadFileRemoteDataSource {
  final ApiManager apiManager;

  UploadFileRemoteDataSourceImpl(
    this.apiManager,
  );

  @override
  Future<Map<String, dynamic>> uploadImageFile(
      {required String bandCodeId,
      required List<String> attachmentList}) async {
    List<MultipartFile> files = [];
    await Future.forEach(attachmentList, (String filePath) async {
      MultipartFile file =
          await MultipartFile.fromFile(filePath, filename: 'files');
      files.add(file);
    });
    var fileData = FormData();
    fileData.fields.addAll({'band_code_id': bandCodeId}.entries);
    for (int i = 0; i < files.length; i++) {
      fileData.files.addAll({'attachments_${i + 1}': files[i]}.entries);
    }
    // Add other form fields

    return await apiManager.makeFileUploadRequest<Map<String, dynamic>>(
        url: AppUrls.emergencyUploadFileUrl,
        method: RequestMethod.POST,
        data: fileData,
        fromJson: (json) => {
          "message": json['message']
        });


  }
}
