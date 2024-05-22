import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mortuary/core/constants/app_assets.dart';
import 'package:mortuary/core/constants/place_holders.dart';
import 'package:mortuary/core/styles/colors.dart';
import 'package:mortuary/core/utils/widget_extensions.dart';
import 'package:mortuary/core/widgets/custom_screen_widget.dart';
import 'package:mortuary/core/widgets/custom_text_widget.dart';
import 'package:mortuary/features/death_report/presentation/components/report_list_component.dart';
import 'package:mortuary/features/splash/presentation/get/splash_controller.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/animated_widget.dart';
import '../../../../core/widgets/button_widget.dart';
import '../../../../core/widgets/load_more_listview.dart';
class DeathReportListScreen extends StatelessWidget {
  DeathReportListScreen({Key? key}) : super(key: key);

  int length = 10;

  @override
  Widget build(BuildContext context) {
    return CustomScreenWidget(
      titleText: AppStrings.deathReportList.toUpperCase(),
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RefreshIndicator(
          onRefresh:getPaginatedAllQuotes ,
          child: LoadMore(
            whenEmptyLoad: true,
            delegate: const DefaultLoadMoreDelegate(),
           isFinish: length == length,
            onLoadMore: getPaginatedAllQuotes,
            child: ListView.builder(
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              itemCount: length,
              itemBuilder: (context, index) {
                return Container(
                    height: 250,
                    child: ReportListItem());
              },
            ),
          ).wrapWithListViewSkeleton(false),
        )

      ]
    );
  }

  Future<bool> getPaginatedAllQuotes() async {
   // await Future.delayed(const Duration(seconds: 5));
    return false;
  }

}
