import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mortuary/core/constants/app_assets.dart';
import 'package:mortuary/core/constants/place_holders.dart';
import 'package:mortuary/core/styles/colors.dart';
import 'package:mortuary/core/widgets/custom_screen_widget.dart';
import 'package:mortuary/core/widgets/custom_text_widget.dart';
import 'package:mortuary/features/authentication/presentation/pages/login_screen.dart';
import 'package:mortuary/features/death_report/presentation/widget/authorized_person/reporter_map_view.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/enums/enums.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../../core/widgets/button_widget.dart';
import 'death_count_screen.dart';
import '../common/death_report_list_screen.dart';

class ReportDeathScreen extends StatelessWidget {
  final UserRole currentUserRole;

  const ReportDeathScreen({Key? key, required this.currentUserRole})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScreenWidget(
        crossAxisAlignment: CrossAxisAlignment.center,
        actions: [
          logoutWidget(
            onTap: (){
              Get.offAll(()=>LoginScreen());
            }
        )],
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
              onTap: () {
                Go.to(() => DeathCountScreen(currentUserRole: currentUserRole));
              },
              child: SvgPicture.asset(AppAssets.icReportDeathButton)),
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
        ]);
  }
}
