import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mortuary/core/constants/app_assets.dart';
import 'package:mortuary/core/constants/place_holders.dart';
import 'package:mortuary/core/popups/show_popups.dart';
import 'package:mortuary/core/styles/colors.dart';
import 'package:mortuary/core/widgets/custom_screen_widget.dart';
import 'package:mortuary/core/widgets/custom_text_widget.dart';
import 'package:mortuary/features/document_upload/presentation/get/document_controller.dart';

import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/enums/enums.dart';
import '../../../../../core/services/image_service.dart';
import '../../../../../core/widgets/button_widget.dart';

class UploadPictureScreen extends StatefulWidget {
  final UserRole currentUserRole;
  final int bandCodeId;

  UploadPictureScreen(
      {Key? key, required this.currentUserRole, required this.bandCodeId})
      : super(key: key);

  @override
  State<UploadPictureScreen> createState() => _UploadPictureScreenState();
}

class _UploadPictureScreenState extends State<UploadPictureScreen> {
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DocumentController>(builder: (controller) {
      return CustomScreenWidget(
          crossAxisAlignment: CrossAxisAlignment.center,
          titleText: AppStrings.uploadPic.toUpperCase(),
          children: [
            const CustomTextWidget(
              text: AppStrings.uploadPicMsgLabel,
              textAlign: TextAlign.center,
              colorText: AppColors.secondaryTextColor,
            ),
            sizeFieldMinPlaceHolder,
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                height: Get.height * 0.6,
                child: imageFile == null
                    ? Image.asset(AppAssets.dummyDocument)
                    : Image.file(imageFile!),
              ),
            ),
            sizeFieldMinPlaceHolder,
            ButtonWidget(
                text: AppStrings.select,
                buttonType: ButtonType.transparent,
                onPressed: () async {
                  final imageSource = await getImageChoiceDialog();
                  if (imageSource != null) {
                    final imageServer = Get.find<ImageService>();
                    final file =
                        await imageServer.pickImage(imageSource: imageSource);
                    if (file != null) {
                      setState(() {
                        imageFile = file;
                      });
                    } else {
                      setState(() {
                        imageFile = null;
                      });
                    }
                  }
                }),
            sizeFieldMinPlaceHolder,
            Visibility(
              visible: imageFile != null,
              child: ButtonWidget(
                  isLoading: controller.isApiResponseLoaded,
                  text: AppStrings.uploadPic,
                  buttonType: ButtonType.gradient,
                  onPressed: () {
                    controller.uploadImageFile([imageFile!.path.toString()],
                        widget.bandCodeId, widget.currentUserRole);
                  }),
            ),
            sizeFieldMediumPlaceHolder,
          ]);
    });
  }
}
