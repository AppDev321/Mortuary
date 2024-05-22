import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mortuary/core/constants/app_assets.dart';
import 'package:mortuary/core/constants/place_holders.dart';
import 'package:mortuary/core/styles/colors.dart';
import 'package:mortuary/core/widgets/custom_screen_widget.dart';
import 'package:mortuary/core/widgets/custom_text_widget.dart';
import 'package:mortuary/features/death_report/presentation/components/report_list_component.dart';
import 'package:mortuary/features/splash/presentation/get/splash_controller.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/animated_widget.dart';
import '../../../../core/widgets/button_widget.dart';
class DeathReportListScreen extends StatelessWidget {
  DeathReportListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScreenWidget(
      titleText: AppStrings.deathReportList.toUpperCase(),
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
    ListView.builder(
        physics: const ScrollPhysics(),
        shrinkWrap: true, // Set shrinkWrap to false
        itemCount: 3,

    itemBuilder: (context, i) {
      return Container(
          child: ReportListItem());
    }),
      ]
    );
  }

}
