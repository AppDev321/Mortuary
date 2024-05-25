import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mortuary/core/utils/widget_extensions.dart';
import 'package:mortuary/core/widgets/custom_screen_widget.dart';
import 'package:mortuary/core/widgets/custom_text_widget.dart';
import 'package:mortuary/features/death_report/presentation/components/report_list_component.dart';
import 'package:mortuary/features/death_report/presentation/get/death_report_controller.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/load_more_listview.dart';
import '../../domain/enities/death_report_list_reponse.dart';

class DeathReportListScreen extends StatefulWidget {
  const DeathReportListScreen({Key? key}) : super(key: key);

  @override
  State<DeathReportListScreen> createState() => _DeathReportListScreenState();
}

class _DeathReportListScreenState extends State<DeathReportListScreen> {
  int listCount = 50;
  int listPageCount = 0;
  List<DeathReportListResponse> paginatedList = [];
  List<DeathReportListResponse> allReportsList = [];

  @override
  void initState() {
    super.initState();
    var controller = Get.find<DeathReportController>();
    controller.getDeathReportList().then((value){
      allReportsList = value;
      getPaginatedList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeathReportController>(builder: (controller) {
      return CustomScreenWidget(
          titleText: AppStrings.deathReportList.toUpperCase(),
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: Get.height * 0.8,
              child: RefreshIndicator(
                onRefresh: controller.getDeathReportList,
                child: controller.deathReportList.isEmpty && controller.isApiResponseLoaded == false
                    ? CustomTextWidget(
                        text: "No Data found",
                      )
                    : LoadMore(
                        whenEmptyLoad: false,
                        delegate: const DefaultLoadMoreDelegate(),
                        isFinish: paginatedList.length ==
                            controller.deathReportList.length,
                        onLoadMore: getPaginationData,
                        child: ListView.builder(
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: paginatedList.length,
                          itemBuilder: (context, index) {
                            var listItem = paginatedList[index];
                            return SizedBox(
                                height: Get.height*0.3, child: ReportListItem(listItem:listItem));
                          },
                        ),
                      ).wrapWithListViewSkeleton( controller.isApiResponseLoaded),
              ),
            )
          ]);
    });
  }

  Future<bool> getPaginationData() async {
    await Future.delayed(const Duration(seconds: 5));
    int startIndex = listPageCount * listCount;
    if (startIndex < allReportsList.length) {
      getPaginatedList();
    }
    return false;
  }

  void getPaginatedList() {
    int startIndex = listPageCount * listCount;
    setState(() {
      paginatedList.clear();
      paginatedList = allReportsList.take(startIndex + listCount).toList();
      listPageCount++;
    });
  }
}
