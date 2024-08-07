
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mortuary/core/constants/app_assets.dart';
import 'package:mortuary/core/constants/place_holders.dart';
import 'package:mortuary/core/error/errors.dart';
import 'package:mortuary/core/popups/show_popups.dart';
import 'package:mortuary/core/styles/colors.dart';
import 'package:mortuary/core/utils/widget_extensions.dart';
import 'package:mortuary/core/widgets/custom_screen_widget.dart';
import 'package:mortuary/core/widgets/custom_text_widget.dart';
import 'package:mortuary/features/authentication/presentation/get/auth_controller.dart';
import 'package:mortuary/features/processing_unit_report/presentation/get/processing_unit_controller.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/enums/enums.dart';
import '../../../../../core/utils/utils.dart';
import 'morgue_upload_picture.dart';

class ProcessDepartment {
  ProcessDepartment({
    required this.id,
    required this.name,
    required this.image,
    this.status = "",
  });

  final int id;
  final String name;
  final String image;
   String status = "";
}

class ProcessingDepartmentScreen extends StatefulWidget {
  final UserRole currentUserRole;
  final String bodyScanCode;
  final String processingCenterId;
  final int deathCaseId;


  const ProcessingDepartmentScreen(
      {Key? key,
      required this.currentUserRole,
      required this.bodyScanCode,
      required this.processingCenterId,
      required this.deathCaseId})
      : super(key: key);

  @override
  State<ProcessingDepartmentScreen> createState() => _ProcessingDepartmentScreenState();
}

class _ProcessingDepartmentScreenState extends State<ProcessingDepartmentScreen> {
  List<ProcessDepartment> departmentList = [
    ProcessDepartment(
        id: 8,
        image: AppAssets.icCleaningBody,
        name: AppStrings.cleaningStation),
    ProcessDepartment(
        id: 9, image: AppAssets.icAutopsy, name: AppStrings.autopsyPostMartam),
    ProcessDepartment(
        id: 10, image: AppAssets.icRefrigerator, name: AppStrings.refrigerator),
    ProcessDepartment(
        id: 11, image: AppAssets.icCementry, name: AppStrings.cementry),
    ProcessDepartment(
        id: 12, image: AppAssets.icCoffin, name: AppStrings.shipToLocal),
  ];

  AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProcessingUnitController>(initState: (_) {
      Get.find<ProcessingUnitController>().currentUserRole = widget.currentUserRole;
    }, builder: (controller) {
      return CustomScreenWidget(
          crossAxisAlignment: CrossAxisAlignment.center,
          titleText: AppStrings.processingDepartment.toUpperCase(),
          actions: [
            GestureDetector(
                onTap: (){
                  Go.to(() => UploadPictureScreen(
                      currentUserRole: widget.currentUserRole,
                      deathCaseID: widget.deathCaseId));
                },
                child:  Padding(
                  padding: const EdgeInsets.all(8),
                    child: SvgPicture.asset(AppAssets.icAttachmentIcon,width:30,height:30)))
          ],
          children: [
            ...departmentList.map((item) {
              return GestureDetector(
                  onTap: () {
                    if(item.id < 11) {
                      controller.showQRCodeScannerScreen(widget.currentUserRole, -111,
                          isMorgueScannedProcessingDepartment: true,
                          onApiCallBack: (scannedQRCode) {
                            controller.postProcessingDepartmentScanCode(
                                scannedQRCode, widget.bodyScanCode, item.id.toString(),
                                widget.processingCenterId, widget.currentUserRole, (response) {
                              setState(() {
                                response['data'].forEach((data) {
                                  if (data is Map<String, dynamic>) {
                                    int id = int.tryParse(data['id'].toString()) ?? 0;
                                    ProcessDepartment? department = departmentList
                                        .firstWhereOrNull((dept) => dept.id == id);
                                    if (department != null) {
                                      department.status = data['progress'] ?? "";
                                    }
                                  }
                                });
                              });

                              var dataDialog = GeneralError(title: AppStrings.scanSuccess, message: AppStrings.scanSuccessMsg);
                              showAppThemedDialog(dataDialog, showErrorMessage: false, onPressed: () {
                                Get.back();
                              });
                            });
                          });
                    }
                    else
                      {
                        controller.postProcessingDepartmentScanCode(
                            "", widget.bodyScanCode, item.id.toString(),
                            widget.processingCenterId, widget.currentUserRole, (response) {
                          setState(() {
                            response['data'].forEach((data) {
                              if (data is Map<String, dynamic>) {
                                int id = int.tryParse(data['id'].toString()) ?? 0;
                                ProcessDepartment? department = departmentList
                                    .firstWhereOrNull((dept) => dept.id == id);
                                if (department != null) {
                                  department.status = data['progress'] ?? "";
                                }
                              }
                            });
                          });
                          var dataDialog = GeneralError(title:AppStrings.success,message:response['message']);
                          showAppThemedDialog(dataDialog,showErrorMessage: false,onPressed: (){
                            Get.back();
                          });
                        });
                      }
                  },
                  child: createContainerView(controller,item.id, item.image, item.name,
                      status: item.status,
                      color: item.status.toLowerCase() == "inprogress"
                          ? Colors.amber
                          :item.status.isEmpty?Colors.transparent: Colors.green));
            }).toList(),
            sizeFieldMediumPlaceHolder,
          ]);
    });
  }

  Widget createContainerView(ProcessingUnitController controller,int departmentCodeId, String image, String title,
      {String status = "", Color color = Colors.amber}) {
    return Container(
        width: Get.width,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border:
                Border.all(color: AppColors.hexToColor("#E1E5F0"), width: 1),
            borderRadius: BorderRadius.circular(20),
            color: Colors.white),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                children: [
                  SvgPicture.asset(image),
                  sizeFieldMediumPlaceHolder,
                  CustomTextWidget(
                    text: title,
                    size: 13,
                    fontWeight: FontWeight.w600,
                    colorText: AppColors.secondaryTextColor,
                  )
                ],
              ),
            ),
            Visibility(
              visible: status != "" || status != "null",
              child: Positioned(
                  right: 0,
                  top: 20,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20)),
                      color: color,
                    ),
                    child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: CustomTextWidget(
                          text: status,
                          colorText: Colors.white,
                        )),
                  )),
            )
          ],
        )).wrapWithListViewSkeleton(controller.isApiResponseLoaded);
  }
}
