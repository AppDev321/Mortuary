import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mortuary/core/widgets/custom_screen_widget.dart';
import 'package:mortuary/features/google_map/google_map_view.dart';

import '../../../../core/constants/app_strings.dart';

class ReportMapViewScreen extends StatelessWidget {
  const ReportMapViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScreenWidget(
      crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        titleText: AppStrings.liveMap, children: [
      Container(
        height: Get.height * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: GoogleMapViewWidget(),
        ),
      ),

    ]);
  }
}
