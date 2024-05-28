import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mortuary/core/utils/utils.dart';

import 'package:mortuary/core/widgets/button_widget.dart';
import 'package:mortuary/features/document_upload/builder_ids.dart';
import 'package:mortuary/features/document_upload/presentation/component/widget_upload_item.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/place_holders.dart';
import '../../../../core/enums/enums.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/widgets/custom_screen_widget.dart';
import '../../../../core/widgets/custom_text_widget.dart';
import '../../../processing_unit_report/presentation/widget/home_screen.dart';
import '../get/document_controller.dart';

class DocumentUploadScreen extends StatelessWidget {
  final UserRole currentUserRole;
  final int bandCodeId;

  DocumentUploadScreen(
      {Key? key, required this.currentUserRole, required this.bandCodeId})
      : super(key: key);

  List<String> attachment = [];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DocumentController>(
        id: updateUploadScreen,
        builder: (controller) {
          return CustomScreenWidget(
              titleText: AppStrings.documents.toUpperCase(),
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Center(
                  child: CustomTextWidget(
                    text: AppStrings.documentsLabel,
                    colorText: AppColors.secondaryTextColor,
                    textAlign: TextAlign.center,
                  ),
                ),
                sizeFieldLargePlaceHolder,
                UploadContainerWidget(
                  headTitle: "${AppStrings.document} 1",
                  currentUserRole: currentUserRole,
                  bandCodeId: bandCodeId,
                  onFileSelected: (file) {
                    attachment.add(file.path);
                  },
                  onFileCanceled: (file) {
                    attachment.remove(file.path);
                  },
                  containerId: 0,
                ),
                sizeFieldMediumPlaceHolder,
                UploadContainerWidget(
                  headTitle: "${AppStrings.document} 2",
                  currentUserRole: currentUserRole,
                  bandCodeId: bandCodeId,
                  onFileSelected: (file) {
                    attachment.add(file.path);
                  },
                  onFileCanceled: (file) {
                    attachment.remove(file.path);
                  },
                  containerId: 1,
                ),
                sizeFieldMediumPlaceHolder,
                UploadContainerWidget(
                  headTitle: "${AppStrings.document} 2",
                  currentUserRole: currentUserRole,
                  bandCodeId: bandCodeId,
                  onFileSelected: (file) {
                    attachment.add(file.path);
                  },
                  onFileCanceled: (file) {
                    attachment.remove(file.path);
                  },
                  containerId: 2,
                ),
                sizeFieldLargePlaceHolder,
                ButtonWidget(
                  text: AppStrings.skip,
                  buttonType: ButtonType.transparent,
                  onPressed: () {
                    Get.offAll(()=>PUHomeScreen(currentUserRole: currentUserRole,));
                  },
                ),
                sizeFieldMediumPlaceHolder,
                ButtonWidget(
                  isLoading: controller.isApiResponseLoaded,
                  text: AppStrings.submit,
                  buttonType: ButtonType.gradient,
                  onPressed: () {
                    if (attachment.isEmpty) {
                      showSnackBar(context,
                          "Please select any document first to upload");
                    } else {
                      controller.uploadImageFile(attachment, bandCodeId,currentUserRole);
                    }
                  },
                ),
              ]);
        });
  }
}
