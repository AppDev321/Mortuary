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
import 'package:mortuary/features/death_report/presentation/widget/reporter_map_view.dart';
import 'package:mortuary/features/processing_unit_report/presentation/get/processing_unit_controller.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/enums/enums.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/button_widget.dart';

import 'death_report_list_screen.dart';

class PUHomeScreen extends StatelessWidget {
  final UserRole currentUserRole;

   PUHomeScreen({Key? key, required this.currentUserRole})
      : super(key: key);

  AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProcessingUnitController>(
      initState: (_){
        Get.find<ProcessingUnitController>().currentUserRole = currentUserRole;
      },
      builder: (controller) {
        return CustomScreenWidget(
            crossAxisAlignment: CrossAxisAlignment.center,
            titleText: authController.session?.loggedUserName.toUpperCase(),
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
                      controller.initiateDeathReport(context,currentUserRole);
                    },
                    child: SvgPicture.asset(AppAssets.icReportDeath)).wrapWithLoadingBool(controller.isApiResponseLoaded),
              ),
              sizeFieldMediumPlaceHolder,
              SizedBox(
                height: Get.height * 0.18,
                child: GestureDetector(
                    onTap: () {
                    controller.showQRCodeScannerScreen(currentUserRole, -111,
                        onApiCallBack: (response) {
                      var dataDialog = GeneralError(
                          title: AppStrings.scanSuccess,
                          message: AppStrings.scanSuccessMsg);
                      showAppThemedDialog(dataDialog,
                          showErrorMessage: false,
                          dissmisableDialog: false, onPressed: () {
                        Get.offAll(
                            PUHomeScreen(currentUserRole: currentUserRole));
                      });
                    });
                  },
                    child: SvgPicture.asset(AppAssets.icReceiveDeath)),
              ),
              sizeFieldLargePlaceHolder,
              ButtonWidget(
                  text: AppStrings.viewLiveMap,
                  buttonType: ButtonType.gradient,
                  textStyle:
                      const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  onPressed: () => Go.to(() => const ReportMapViewScreen())),
              sizeFieldMediumPlaceHolder,
              ButtonWidget(
                  text: AppStrings.viewDeathReportList,
                  buttonType: ButtonType.transparent,
                  textStyle:
                      const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  onPressed: () => Go.to(() =>  DeathReportListScreen(userRole: currentUserRole,))),
              sizeFieldMediumPlaceHolder,
              ButtonWidget(
                  text: AppStrings.handOverBody,
                  buttonType: ButtonType.gradient,
                  textStyle:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  onPressed: () => Go.to(() => const ReportMapViewScreen())),

              sizeFieldMediumPlaceHolder,
            ]);


      }
    );
  }
}
