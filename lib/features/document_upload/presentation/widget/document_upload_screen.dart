
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
import '../../../processing_unit_report/presentation/widget/processing_unit/home_screen.dart';
import '../../domain/entity/attachment_type.dart';
import '../get/document_controller.dart';

class DocumentUploadScreen extends StatelessWidget {
  final UserRole currentUserRole;
  final int bandCodeId;
  final List<AttachmentType> attachmentsTypes;
  bool closeOnlyDocumentScreen = false;

  DocumentUploadScreen(
      {Key? key,
      required this.currentUserRole,
      required this.bandCodeId,
      required this.attachmentsTypes,
      this.closeOnlyDocumentScreen = false})
      : super(key: key);

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
                Column(
                  children: attachmentsTypes
                      .map((item) => Column(children: [
                            sizeFieldMediumPlaceHolder,
                            UploadContainerWidget(
                              headTitle: item.name,
                              currentUserRole: currentUserRole,
                              bandCodeId: bandCodeId,
                              onFileSelected: (file) {
                                item.path = file.path;
                              },
                              onFileCanceled: (file) {
                                item.path = "";
                              },
                              containerId: item.id,
                            ),
                          ]))
                      .toList(),
                ),
                sizeFieldLargePlaceHolder,
                ButtonWidget(
                  text: closeOnlyDocumentScreen ? AppStrings.cancelButtonText : AppStrings.skip,
                  buttonType: ButtonType.transparent,
                  onPressed: () {
                    if (closeOnlyDocumentScreen) {
                      Get.back();
                    } else {
                      Get.offAll(() => PUHomeScreen(
                            currentUserRole: currentUserRole,
                          ));
                    }
                  },
                ),
                sizeFieldMediumPlaceHolder,
                ButtonWidget(
                  isLoading: controller.isApiResponseLoaded,
                  text: AppStrings.uploadDocument,
                  buttonType: ButtonType.gradient,
                  onPressed: () {
                    if (hasPathValue(attachmentsTypes) == false) {
                      showSnackBar(context, "Please select any document first to upload");
                    } else {
                      controller.uploadAttachmentTypes(attachmentsTypes, bandCodeId, currentUserRole);
                    }
                  },
                ),
              ]);
        });
  }

  bool hasPathValue(List<AttachmentType> attachmentsTypes) {
    for (var attachmentType in attachmentsTypes) {
      if (attachmentType.path.toString().isNotEmpty) {
        return true;
      }
    }
    return false;
  }
}
