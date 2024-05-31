
import 'package:mortuary/features/document_upload/data/data_source/upload_remote_source.dart';

import '../../../../core/enums/enums.dart';
import '../../../../core/network/api_manager.dart';
import '../../domain/entity/attachment_type.dart';


abstract class UploadFileRepo {
  Future<Map<String, dynamic>> uploadImageFile(
      {required UserRole userRole, required String bandCodeId, required List<String> attachmentList});

  Future<Map<String, dynamic>> uploadAttachmentTypes(
      {required UserRole userRole, required String bandCodeId, required List<AttachmentType> attachmentList});
}

class UploadFileRepoImpl extends UploadFileRepo {
  final UploadFileRemoteDataSource remoteDataSource;
  final ApiManager apiManager;

  UploadFileRepoImpl({
    required this.remoteDataSource,
    required this.apiManager,
  });



  @override
  Future<Map<String, dynamic>> uploadImageFile({required UserRole userRole, required String bandCodeId, required List<String> attachmentList}) {
    return apiManager.handleRequest(() async {
      return await remoteDataSource.uploadImageFile(
        userRole: userRole,
          bandCodeId: bandCodeId,
          attachmentList: attachmentList
      );
    });
  }

  @override
  Future<Map<String, dynamic>> uploadAttachmentTypes({required userRole, required String bandCodeId,
    required List<AttachmentType> attachmentList}) {
    return apiManager.handleRequest(() async {
      return await remoteDataSource.uploadAttachmentTypes(
          bandCodeId: bandCodeId,
          attachmentList: attachmentList,
          userRole:userRole
      );
    });
  }
}
