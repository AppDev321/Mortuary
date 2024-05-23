import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mortuary/core/constants/app_assets.dart';
import 'package:mortuary/core/constants/place_holders.dart';
import 'package:mortuary/core/styles/colors.dart';
import 'package:mortuary/core/widgets/custom_screen_widget.dart';
import 'package:mortuary/core/widgets/custom_text_widget.dart';
import 'package:mortuary/features/splash/presentation/get/splash_controller.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/animated_widget.dart';
import '../../../../core/widgets/button_widget.dart';
import 'death_report_form.dart';
import 'death_report_list_screen.dart';
class ReportDeathScreen extends StatelessWidget {
  ReportDeathScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return CustomScreenWidget(
      crossAxisAlignment: CrossAxisAlignment.center,

      children: [
        CustomTextWidget(
          text: AppStrings.reportDeath.toUpperCase(),
          size: 24,
          fontWeight: FontWeight.w700,
        ),
        sizeFieldLargePlaceHolder,
        const CustomTextWidget(
          text: AppStrings.reportDeathLabelMsg,
          size: 13,
          colorText: AppColors.secondaryTextColor,
          textAlign: TextAlign.center,
        ),
        sizeFieldLargePlaceHolder,
        sizeFieldLargePlaceHolder,
        GestureDetector(
          onTap: (){
            print("here");
            Go.to(()=>DeathReportFormScreen());},
            child: SvgPicture.asset(AppAssets.icReportDeathButton)),
        sizeFieldLargePlaceHolder,
        ButtonWidget(
          text: AppStrings.viewLiveMap,
          buttonType: ButtonType.gradient,
          textStyle: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w600),
          onPressed: null),
        sizeFieldMediumPlaceHolder,
        ButtonWidget(
            text: AppStrings.viewDeathReportList,
            buttonType: ButtonType.transparent,
            textStyle: TextStyle(
                fontSize: 15, fontWeight: FontWeight.w600),
              onPressed: () => Get.to(() => DeathReportListScreen())),
        ]
    );
  }
}
