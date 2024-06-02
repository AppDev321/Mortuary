import 'dart:core';

import 'package:dio/dio.dart';
import 'package:mortuary/core/enums/enums.dart';
import '../../../../core/constants/app_urls.dart';
import '../../../../core/network/api_manager.dart';
import '../../domain/entity/attachment_type.dart';

abstract class UploadFileRemoteDataSource {
  Future<Map<String, dynamic>> uploadImageFile(
      {required UserRole userRole, required String bandCodeId, required List<String> attachmentList});

  Future<Map<String, dynamic>> uploadAttachmentTypes(
      {required UserRole userRole, required String bandCodeId, required List<AttachmentType> attachmentList});
}

class UploadFileRemoteDataSourceImpl implements UploadFileRemoteDataSource {
  final ApiManager apiManager;

  UploadFileRemoteDataSourceImpl(
    this.apiManager,
  );

  @override
  Future<Map<String, dynamic>> uploadImageFile(
      {required UserRole userRole, required String bandCodeId, required List<String> attachmentList}) async {
    List<MultipartFile> files = [];
    await Future.forEach(attachmentList, (String filePath) async {
      MultipartFile file = await MultipartFile.fromFile(filePath, filename: 'files');
      files.add(file);
    });
    var fileData = FormData();
    if (userRole == UserRole.morgue) {
      fileData.fields.addAll({'death_case_id': bandCodeId}.entries);
      for (int i = 0; i < files.length; i++) {
        fileData.files.addAll({'attachments': files[i]}.entries);
      }
    } else {
      fileData.fields.addAll({'band_code_id': bandCodeId}.entries);
      for (int i = 0; i < files.length; i++) {
        fileData.files.addAll({'attachments_${i + 1}': files[i]}.entries);
      }
    }

    // Add other form fields

    return await apiManager.makeFileUploadRequest<Map<String, dynamic>>(
        url: userRole == UserRole.emergency ? AppUrls.emergencyUploadFileUrl : AppUrls.morgueUploadFileUrl,
        method: RequestMethod.POST,
        data: fileData,
        fromJson: (json) => {"message": json['message']});
  }

  @override
  Future<Map<String, dynamic>> uploadAttachmentTypes(
      {required UserRole userRole, required String bandCodeId, required List<AttachmentType> attachmentList}) async {
    List<MultipartFile> files = [];
    List<int> attachmentId = [];
    for (var attachment in attachmentList) {
      if (attachment.path.toString().isNotEmpty) {
        MultipartFile file = await MultipartFile.fromFile(attachment.path.toString(), filename: 'files');
        files.add(file);
        attachmentId.add(attachment.id);
      }
    }

    var fileData = FormData();

      fileData.fields.addAll({'band_code_id': bandCodeId}.entries);
      for (int i = 0; i < files.length; i++) {
        fileData.files.addAll({'attachments_${attachmentId[i]}': files[i]}.entries);
      }
    print(fileData.fields);
      print(fileData.files);

    // Add other form fields

    return await apiManager.makeFileUploadRequest<Map<String, dynamic>>(
        url: userRole == UserRole.emergency ? AppUrls.emergencyUploadFileUrl : AppUrls.morgueUploadFileUrl,
        method: RequestMethod.POST,
        data: fileData,
        fromJson: (json) => {"message": json['message']});
  }
}
