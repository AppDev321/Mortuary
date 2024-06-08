import 'package:get/get.dart';
import 'package:mortuary/features/authentication/domain/enities/user_model.dart';
import 'package:mortuary/features/document_upload/data/repository/upload_file_repo.dart';
import 'package:mortuary/features/document_upload/domain/entity/attachment_type.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/enums/enums.dart';
import '../../../../core/error/errors.dart';
import '../../../../core/popups/show_popups.dart';
import '../../../../event_bus.dart';
import '../../../processing_unit_report/presentation/widget/processing_unit/home_screen.dart';
import '../../builder_ids.dart';
import '../../data/data_source/upload_remote_source.dart';

class DocumentController extends GetxController {
  final UploadFileRepo uploadFileRepo;

  DocumentController({required this.uploadFileRepo});

  var apiResponseLoaded = LoadingState.loaded;

  bool get isApiResponseLoaded => apiResponseLoaded == LoadingState.loading;

  uploadImageFile(List<String> attachments, int bandCodeId,UserRole userRole) {
    onApiRequestStarted();
    uploadFileRepo
        .uploadImageFile(bandCodeId: '$bandCodeId', attachmentList: attachments,userRole:userRole)
        .then((value) {

      onApiResponseCompleted();
      var dataDialog = GeneralError(title:AppStrings.upload,message: value['message']);
      showAppThemedDialog(dataDialog,showErrorMessage: false,dissmisableDialog: false,onPressed: (){
        if(userRole == UserRole.morgue){
          Get.back();
        }else {
          Get.offAll(() => PUHomeScreen(currentUserRole: userRole,));
        }
      });

    }).onError<CustomError>((error, stackTrace) async {
      onErrorShowDialog(error);
    });
  }


  uploadAttachmentTypes(List<AttachmentType> attachments, int bandCodeId,UserRole userRole) {
    onApiRequestStarted();
    uploadFileRepo
        .uploadAttachmentTypes(bandCodeId: '$bandCodeId', attachmentList: attachments,userRole:userRole)
        .then((value) {

      onApiResponseCompleted();
      var dataDialog = GeneralError(title:AppStrings.upload,message: value['message']);
      showAppThemedDialog(dataDialog,showErrorMessage: false,onPressed: (){
        eventBus.fire(RefreshDetailReportScreen());
        // if(userRole == UserRole.morgue){
        //   Get.back();
        // }else {
        //   Get.offAll(() => PUHomeScreen(currentUserRole: userRole,));
        // }
      });

    }).onError<CustomError>((error, stackTrace) async {
      onErrorShowDialog(error);
    });
  }


  morgueUploadImageFile(List<String> attachments, int bandCodeId,UserRole userRole) {
    onApiRequestStarted();
    uploadFileRepo
        .uploadImageFile(bandCodeId: '$bandCodeId', attachmentList: attachments,userRole: userRole)
        .then((value) {

      onApiResponseCompleted();
      var dataDialog = GeneralError(title:AppStrings.upload,message: value['message']);
      showAppThemedDialog(dataDialog,showErrorMessage: false,dissmisableDialog: false,onPressed: (){

      });

    }).onError<CustomError>((error, stackTrace) async {
      onErrorShowDialog(error);
    });
  }



  onErrorShowDialog(error) {
    onApiResponseCompleted();
    showAppThemedDialog(error);
  }

  onApiResponseCompleted() {
    apiResponseLoaded = LoadingState.loaded;
    onUpdateUI();
  }

  onApiRequestStarted() {
    apiResponseLoaded = LoadingState.loading;
    onUpdateUI();
  }

  onUpdateUI() {
    update();
    update([updateUploadScreen]);
    //update([updatedAuthWrapper, updateEmailScreen, updateOTPScreen]);
  }
}
