
import '../../../../core/network/api_manager.dart';


abstract class UploadFileRepo {
  Future<Map<String, dynamic>> uploadImageFile(
      {required String bandCodeId, required List<String> attachmentList});

}

class UploadFileRepoImpl extends UploadFileRepo {
  final UploadFileRepoImpl remoteDataSource;
  final ApiManager apiManager;

  UploadFileRepoImpl({
    required this.remoteDataSource,
    required this.apiManager,
  });



  @override
  Future<Map<String, dynamic>> uploadImageFile({required String bandCodeId, required List<String> attachmentList}) {
    return apiManager.handleRequest(() async {
      return await remoteDataSource.uploadImageFile(
          bandCodeId: bandCodeId,
          attachmentList: attachmentList
      );
    });
  }
}
