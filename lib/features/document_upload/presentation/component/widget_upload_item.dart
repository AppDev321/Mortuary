import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/place_holders.dart';
import '../../../../core/enums/enums.dart';
import '../../../../core/popups/show_popups.dart';
import '../../../../core/services/image_service.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/widgets/custom_text_widget.dart';
import '../get/document_controller.dart';

class UploadContainerWidget extends StatefulWidget {
  final UserRole currentUserRole;
  final int bandCodeId;
  final String headTitle;
  final int containerId;
  final Function(File) onFileSelected;
  final  Function(File) onFileCanceled;



  const UploadContainerWidget(
      {Key? key,
      required this.currentUserRole,
      required this.bandCodeId,
      required this.headTitle,
        required this.onFileSelected,
        required  this.onFileCanceled,
        required this. containerId

      })
      : super(key: key);

  @override
  State<UploadContainerWidget> createState() => _UploadContainerWidgetState();
}

class _UploadContainerWidgetState extends State<UploadContainerWidget> {
  String attachmentPath = "";
  String fileName = "";
  bool isContainerVisible = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DocumentController>(builder: (controller) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 26.0, bottom: 5),
            child: CustomTextWidget(
              text: widget.headTitle,
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
                      final file =
                          await imageServer.pickImage(imageSource: imageSource);
                      if (file != null) {
                        setState(() {
                          isContainerVisible = true;
                          attachmentPath = file.path;
                          fileName = getFileName(file);
                        });

                        widget.onFileSelected.call(file);
                      } else {
                        setState(() {
                          isContainerVisible = false;
                        });
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
                margin: EdgeInsets.only(left: 16, top: 10),
                decoration: BoxDecoration(
                  color: AppColors.hexToColor("#E1E5F0"),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomTextWidget(
                      text: fileName,
                      colorText: AppColors.secondaryTextColor,
                    ),
                    sizeHorizontalFieldSmallPlaceHolder,
                    InkWell(
                      onTap: (){
                        widget.onFileCanceled.call(File(attachmentPath));
                        setState(() {
                          isContainerVisible = false;
                          attachmentPath = "";
                          fileName = "";
                        });

                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(AppAssets.icRemoveAttachment),
                      ),
                    ),
                  ],
                ),
              ))
        ],
      );
    });
  }

  String getFileName(File file) {
    String path = file.path;
    int lastIndex = path.lastIndexOf(Platform.pathSeparator);
    String fileName = path.substring(lastIndex + 1);
    return fileName;
  }
}
