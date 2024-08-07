import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mortuary/core/constants/app_assets.dart';
import 'package:mortuary/core/constants/place_holders.dart';
import 'package:mortuary/core/utils/widget_extensions.dart';
import 'package:mortuary/core/widgets/custom_screen_widget.dart';
import 'package:mortuary/core/widgets/custom_text_widget.dart';
import 'package:mortuary/features/authentication/presentation/get/auth_controller.dart';
import 'package:mortuary/features/processing_unit_report/presentation/get/processing_unit_controller.dart';
import 'package:mortuary/features/processing_unit_report/presentation/widget/morgue/processing_department.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/enums/enums.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../../core/widgets/button_widget.dart';
import '../../../../authentication/presentation/pages/login_screen.dart';
import '../common/death_report_list_screen.dart';


class MorgueHomeScreen extends StatelessWidget {
  final UserRole currentUserRole;

  MorgueHomeScreen({Key? key, required this.currentUserRole})
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
            actions: [
              logoutWidget(onTap: () {
                Get.offAll(() => LoginScreen());
              })
            ],
            children: [

              CustomTextWidget(
                text: authController.session?.loggedUserName.toUpperCase(),
                size: 24,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(
                height: Get.height*0.1,
              ),

              SizedBox(
                height: Get.height * 0.4,
                child: GestureDetector(
                    onTap: () {
                      controller.showQRCodeScannerScreen(currentUserRole,-111,onApiCallBack: (response){
                        Get.off(()=>ProcessingDepartmentScreen(
                          currentUserRole: currentUserRole,
                          bodyScanCode: response['qr_code'],
                          processingCenterId: response['processing_center_id'],
                          deathCaseId: response['death_case_id']
                        ));
                      });
                    },
                    child: SvgPicture.asset(AppAssets.icMorgueReceivedBody)).wrapWithLoadingBool(controller.isApiResponseLoaded),
              ),
              sizeFieldLargePlaceHolder,
              sizeFieldLargePlaceHolder,

              ButtonWidget(
                  text: AppStrings.viewDeathReportList,
                  buttonType: ButtonType.transparent,
                  textStyle:
                      const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  onPressed: () => Go.to(() =>  DeathReportListScreen(userRole: currentUserRole,))),
              sizeFieldMediumPlaceHolder,

            ]);


      }
    );
  }
}
