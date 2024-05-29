import 'package:get/get.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/enums/enums.dart';
import '../../../../core/error/errors.dart';
import '../../../../core/popups/show_popups.dart';
import '../../../processing_unit_report/presentation/widget/processing_unit/home_screen.dart';
import '../../builder_ids.dart';
import '../../data/data_source/upload_remote_source.dart';

class DocumentController extends GetxController {
  final UploadFileRemoteDataSource uploadFileRemoteDataSource;

  DocumentController({required this.uploadFileRemoteDataSource});

  var apiResponseLoaded = LoadingState.loaded;

  bool get isApiResponseLoaded => apiResponseLoaded == LoadingState.loading;

  uploadImageFile(List<String> attachments, int bandCodeId,UserRole userRole) {
    onApiRequestStarted();
    uploadFileRemoteDataSource
        .uploadImageFile(bandCodeId: '$bandCodeId', attachmentList: attachments)
        .then((value) {

      onApiResponseCompleted();
      var dataDialog = GeneralError(title:AppStrings.upload,message: value['message']);
      showAppThemedDialog(dataDialog,showErrorMessage: false,dissmisableDialog: false,onPressed: (){
        Get.offAll(()=>PUHomeScreen(currentUserRole: userRole,));
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
