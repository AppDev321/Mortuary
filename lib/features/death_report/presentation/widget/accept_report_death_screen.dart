import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mortuary/core/constants/app_assets.dart';
import 'package:mortuary/core/constants/place_holders.dart';
import 'package:mortuary/core/styles/colors.dart';
import 'package:mortuary/core/utils/widget_extensions.dart';
import 'package:mortuary/core/widgets/custom_screen_widget.dart';
import 'package:mortuary/core/widgets/custom_text_widget.dart';
import 'package:mortuary/features/death_report/presentation/get/death_report_controller.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/enums/enums.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/button_widget.dart';
import '../../domain/enities/death_report_alert.dart';
import 'death_count_screen.dart';
import 'death_report_list_screen.dart';

class AcceptDeathAlertScreen extends StatelessWidget {
  final DeathReportAlert dataModel;
  final UserRole userRole;
  final VoidCallback onReportHistoryButton;

  const AcceptDeathAlertScreen(
      {Key? key,
      required this.dataModel,
      required this.userRole,
      required this.onReportHistoryButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeathReportController>(
      initState: Get.find<DeathReportController>().setUserRole(userRole),
      builder: (controller) {
        return CustomScreenWidget(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CustomTextWidget(
                  text: AppStrings.newDeathAlertTitle.toUpperCase(),
                  size: 24,
                  fontWeight: FontWeight.w700,
                  textAlign: TextAlign.center,
                ),
              ),
              sizeFieldMediumPlaceHolder,
              Center(
                child: const CustomTextWidget(
                  text: AppStrings.newDeathLabelMsg,
                  size: 13,
                  colorText: AppColors.secondaryTextColor,
                  textAlign: TextAlign.center,
                ),
              ),
              sizeFieldLargePlaceHolder,
              CustomTextWidget(
                text: AppStrings.reportDetail.toUpperCase(),
                size: 18,
                fontWeight: FontWeight.w700,
                textAlign: TextAlign.left,
              ),
              sizeFieldMediumPlaceHolder,
              Table(
                children: [
                  createInfoRow(AppAssets.icPerson, AppStrings.noOfDeath,
                      dataModel.noOfDeaths),
                  rowSpacer,
                  createInfoRow(AppAssets.icLocation, AppStrings.generalLocation,
                      dataModel.generalLocation),
                  rowSpacer,
                  createInfoRow(AppAssets.icCalender,AppStrings.date,convertAppStyleDate(dataModel.reportDate)),
                  rowSpacer,
                  createInfoRow(
                      AppAssets.icTime, AppStrings.time, dataModel.reportTime),
                  rowSpacer,
                  createInfoRow(AppAssets.icLocation, AppStrings.address,
                      dataModel.address ?? "N/A"),
                ],
              ),
              sizeFieldMediumPlaceHolder,
              SizedBox(
                height: 170,
                child: GestureDetector(
                  onTap: (){
                    controller.acceptDeathReportByTransport(dataModel);
                  },
                  child: Center(
                      child: SvgPicture.asset(
                    AppAssets.icAcceptButton,
                    height: 170,
                  )),
                ).wrapWithLoadingBool(controller.isApiResponseLoaded),
              ),
              sizeFieldMediumPlaceHolder,
              Center(
                child: ButtonWidget(
                    text: AppStrings.viewDeathReportList,
                    buttonType: ButtonType.transparent,
                    textStyle:
                        const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    onPressed: () {
                      Get.back();
                      onReportHistoryButton();
                    }),
              ),
            ]);
      }
    );
  }

  createInfoRow(String assets, String title, String body) {
    return TableRow(children: [
      Row(
        children: [
          SvgPicture.asset(assets),
          sizeHorizontalMinPlaceHolder,
          Expanded(
            child: CustomTextWidget(
              text: title,
              colorText: AppColors.hexToColor("#667085"),
              fontWeight: FontWeight.w500,
              size: 14,
            ),
          ),
        ],
      ),

      CustomTextWidget(
        text: body,
        colorText: AppColors.hexToColor("#AEAEAE"),
        fontWeight: FontWeight.w500,
        size: 14,
      )
    ]);
  }

  static const rowSpacer = TableRow(children: [
    SizedBox(
      height: 5,
    ),
    SizedBox(
      height: 5,
    )
  ]);
}
