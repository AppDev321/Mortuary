import 'package:get/get.dart';
import 'package:mortuary/features/document_upload/data/data_source/upload_remote_source.dart';
import 'package:mortuary/features/document_upload/data/repository/upload_file_repo.dart';
import 'package:mortuary/features/document_upload/presentation/get/document_controller.dart';
import '../../core/services/image_service.dart';
import '../../core/services/picker_decider.dart';

initUpload() async {
  Get.lazyPut<UploadFileRemoteDataSource>(() => UploadFileRemoteDataSourceImpl(Get.find()), fenix: true);
  Get.lazyPut<UploadFileRepo>(() => UploadFileRepoImpl(remoteDataSource: Get.find(), apiManager: Get.find()), fenix: true);
  Get.lazyPut<DocumentController>(() => DocumentController(uploadFileRepo: Get.find()));
  Get.lazyPut<FileChooserService>(() => FileChooserServiceImpl());
  Get.lazyPut<ImageService>(() => ImageServiceImpl());
}
