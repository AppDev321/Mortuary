import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mortuary/core/constants/app_assets.dart';
import 'package:mortuary/core/services/image_service.dart';
import 'package:mortuary/core/widgets/button_widget.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/place_holders.dart';
import '../../../../core/enums/enums.dart';
import '../../../../core/popups/show_popups.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/widgets/custom_screen_widget.dart';
import '../../../../core/widgets/custom_text_widget.dart';
import '../get/document_controller.dart';

class DocumentUploadScreen extends StatelessWidget {
  final UserRole currentUserRole;

  DocumentUploadScreen({Key? key, required this.currentUserRole})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DocumentController>(builder: (controller) {
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
            createUploadDocumentContainer("${AppStrings.document} 1"),
            sizeFieldMediumPlaceHolder,
            createUploadDocumentContainer("${AppStrings.document} 2"),
            sizeFieldMediumPlaceHolder,
            createUploadDocumentContainer("${AppStrings.document} 3"),
            sizeFieldLargePlaceHolder,
            ButtonWidget(
                text: AppStrings.submit, buttonType: ButtonType.gradient)
          ]);
    });
  }

  createUploadDocumentContainer(String headTitle,{bool isContainerVisible = false}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Padding(
          padding: EdgeInsets.only(left: 26.0, bottom: 5),
          child: CustomTextWidget(
            text: headTitle,
            size: 14,
            colorText: AppColors.blackColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 16.0, right: 16),
          //  padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30.0),
            border: Border.all(color: AppColors.hexToColor("#E1E5F0")),
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: const CustomTextWidget(
                    text: AppStrings.document,
                    colorText: AppColors.secondaryTextColor,
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  final imageSource = await getImageChoiceDialog();

                  if (imageSource != null) {
                    final imageServer = Get.find<ImageService>();
                    final file = await imageServer.pickImage(imageSource: imageSource);
                    if (file != null) {
                    print(file);
                    }
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12.0),
                  decoration: BoxDecoration(
                    color: AppColors.hexToColor("#E1E5F0"),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(AppAssets.icAttachment),
                      sizeHorizontalMinPlaceHolder,
                      const CustomTextWidget(
                        text: AppStrings.upload,
                        colorText: AppColors.secondaryTextColor,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Visibility(
            visible: isContainerVisible,
            child: Container(
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.only(left: 16,top: 10),
              decoration: BoxDecoration(
                color: AppColors.hexToColor("#E1E5F0"),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                 const CustomTextWidget(
                    text:'Attachment 01',
                    colorText: AppColors.secondaryTextColor,
                  ),
                  sizeHorizontalFieldSmallPlaceHolder,
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(AppAssets.icRemoveAttachment),
                  ),
                ],
              ),
            )
        )
      ],
    );
  }
}
