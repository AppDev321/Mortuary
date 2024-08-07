import 'package:flutter/cupertino.dart';
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
import 'package:mortuary/features/death_report/presentation/widget/authorized_person/reporter_map_view.dart';
import 'package:mortuary/features/document_upload/domain/entity/attachment_type.dart';
import 'package:mortuary/features/processing_unit_report/presentation/get/processing_unit_controller.dart';
import 'package:mortuary/features/processing_unit_report/presentation/widget/processing_unit/police_station_screen.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/enums/enums.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../../core/widgets/button_widget.dart';

import '../../../../authentication/presentation/pages/login_screen.dart';
import '../common/death_report_list_screen.dart';

class PUHomeScreen extends StatelessWidget {
  final UserRole currentUserRole;

  PUHomeScreen({Key? key, required this.currentUserRole}) : super(key: key);

  AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProcessingUnitController>(initState: (_) {
      Get.find<ProcessingUnitController>().currentUserRole = currentUserRole;
    }, builder: (controller) {
      return CustomScreenWidget(
          crossAxisAlignment: CrossAxisAlignment.center,
          titleText: authController.session?.loggedUserName.toUpperCase(),
          actions: [
            logoutWidget(onTap: () {
              Get.offAll(() => LoginScreen());
            })
          ],
          children: [
            CupertinoSwitch(
              activeColor: AppColors.hexToColor("#4CAF50"),
              thumbColor: AppColors.hexToColor("#E8F5E9"),
              trackColor: Colors.grey,
              value: controller.isBedSpaceAvailable,
              onChanged: controller.setBedSpace,
            ),
            sizeFieldMediumPlaceHolder,
            const CustomTextWidget(
              text: AppStrings.spaceAvailabilityCenter,
              size: 13,
              colorText: AppColors.secondaryTextColor,
              textAlign: TextAlign.center,
            ),
            sizeFieldLargePlaceHolder,
            SizedBox(
              height: Get.height * 0.18,
              child: GestureDetector(
                      onTap: () {
                        controller.initiateDeathReport(context, currentUserRole);
                      },
                      child: SvgPicture.asset(AppAssets.icReportDeath))
                  .wrapWithLoadingBool(controller.isApiResponseLoaded),
            ),
            sizeFieldMediumPlaceHolder,
            SizedBox(
              height: Get.height * 0.18,
              child: GestureDetector(
                  onTap: () {
                    controller.showQRCodeScannerScreen(currentUserRole, -111,
                        isEmergencyReceivedABody: true, onApiCallBack: (response) {
                      var dataDialog = GeneralError(title: AppStrings.scanSuccess, message: AppStrings.scanSuccessMsg);
                      showAppThemedDialog(dataDialog, showErrorMessage: false, dissmisableDialog: false, onPressed: () {

                       var attachmentList = response['attachmentType'] as List<AttachmentType>;
                        var bandCodeID = response['band_code'];
                        var message = response['message'];
                        //
                        // Get.offAll(
                        //     PUHomeScreen(currentUserRole: currentUserRole));
                        Get.off(() => PoliceStationScreen(
                              deathBodyBandCode: bandCodeID,
                              deathFormCode: -1,
                              isBodyReceivedFromAmbulance: true,
                              attachmentList: attachmentList,
                              policeStationList: response['stations'],
                             apiResponseMessage: message,

                            ));
                      });
                    });
                  },
                  child: SvgPicture.asset(AppAssets.icReceiveDeath)),
            ),
            sizeFieldLargePlaceHolder,
            ButtonWidget(
                text: AppStrings.viewLiveMap,
                buttonType: ButtonType.gradient,
                textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                onPressed: () => Go.to(() => const ReportMapViewScreen())),
            sizeFieldMediumPlaceHolder,
            ButtonWidget(
                text: AppStrings.viewDeathReportList,
                buttonType: ButtonType.transparent,
                textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                onPressed: () => Go.to(() => DeathReportListScreen(
                      userRole: currentUserRole,
                    ))),
            sizeFieldMediumPlaceHolder,
          ]);
    });
  }
}
