import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mortuary/core/constants/app_assets.dart';
import 'package:mortuary/core/popups/show_popups.dart';
import 'package:mortuary/core/utils/app_config_service.dart';
import 'package:mortuary/core/utils/validators.dart';
import 'package:mortuary/core/widgets/button_widget.dart';
import 'package:mortuary/features/death_report/presentation/get/death_report_controller.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/place_holders.dart';
import '../../../../core/enums/enums.dart';
import '../../../../core/widgets/custom_screen_widget.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/custom_text_widget.dart';
import '../../../qr_scanner/presentation/widget/ai_barcode_scanner.dart';

class DeathCountScreen extends StatelessWidget {
  final UserRole currentUserRole;

  DeathCountScreen({Key? key, required this.currentUserRole}) : super(key: key);
  final deathCountKey = GlobalKey<FormState>();
  TextEditingController locationTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: deathCountKey,
      child: GetBuilder<DeathReportController>(

          initState:
              Get.find<DeathReportController>().setUserRole(currentUserRole),
          builder: (controller) {
           return CustomScreenWidget(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomTextWidget(
                    text: AppStrings.numberOfDeaths.toUpperCase(),
                    size: 24,
                    fontWeight: FontWeight.w700,
                  ),
                  sizeFieldLargePlaceHolder,
                  sizeFieldLargePlaceHolder,
                  sizeFieldLargePlaceHolder,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ButtonWidget(
                        expand: false,
                        text: "-",
                        buttonType: ButtonType.transparent,
                        radius: 15,
                        width: 60,
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                        onPressed: () {
                          if (controller.deathNumberCount > 1) {
                            controller.deathNumberCount--;
                          } else {
                            controller.deathNumberCount = 1;
                          }
                          controller.update();
                        },
                      ),
                      CustomTextWidget(
                        text: '${controller.deathNumberCount}',
                        size: 25,
                        fontWeight: FontWeight.w700,
                      ),
                      ButtonWidget(
                        expand: false,
                        text: "+",
                        buttonType: ButtonType.transparent,
                        radius: 15,
                        width: 60,
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                        onPressed: () {
                          controller.deathNumberCount++;
                          controller.update();
                        },
                      ),
                    ],
                  ),
                  sizeFieldLargePlaceHolder,
                  sizeFieldLargePlaceHolder,
                   CustomTextField(
                     controller: locationTextController,
                    suffixIcon: const Icon(Icons.keyboard_arrow_down),
                    headText: AppStrings.generalLocation,
                    borderEnable: true,
                    validator: EmptyFieldValidator.validator,
                    readOnly: true,
                    fontWeight: FontWeight.normal,
                    onTap: (){
                      showRadioOptionDialog(
                          context,
                          AppStrings.generalLocation,
                          ConfigService().getGeneralLocation(),
                          controller.selectedGeneralLocation,
                              (onChanged) => controller.selectedGeneralLocation,
                              (onConfirmed){
                                    controller.setGeneralLocation(onConfirmed!);
                                    controller.update();
                                    locationTextController.text =  controller.selectedGeneralLocation?.name ?? "";
                              },
                              (itemToString) => itemToString?.name ?? "");
                    }, text: AppStrings.selectLocation,
                  ),
                  sizeFieldLargePlaceHolder,
                  ButtonWidget(
                    isLoading: controller.isApiResponseLoaded,
                    text: AppStrings.sharePinLocation,
                    buttonType: ButtonType.gradient,
                    icon: SvgPicture.asset(AppAssets.icPinLocation),
                    textStyle: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w600),
                    onPressed: () async{
                       if(deathCountKey.currentState!.validate()) {
                           controller.initiateVolunteerDeathReport(context);
                       }
                    },
                  ),
                ]);
          }),
    );
  }
}
