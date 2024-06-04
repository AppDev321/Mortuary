import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mortuary/core/constants/api_messages.dart';
import 'package:mortuary/core/constants/app_assets.dart';
import 'package:mortuary/core/constants/place_holders.dart';
import 'package:mortuary/core/enums/enums.dart';
import 'package:mortuary/core/utils/widget_extensions.dart';
import 'package:mortuary/core/widgets/custom_screen_widget.dart';
import 'package:mortuary/core/widgets/custom_text_field.dart';
import 'package:mortuary/core/widgets/custom_text_widget.dart';
import 'package:mortuary/features/death_report/domain/enities/death_report_alert.dart';
import 'package:mortuary/features/death_report/presentation/components/report_list_component.dart';
import 'package:mortuary/features/death_report/presentation/get/death_report_controller.dart';
import 'package:mortuary/features/death_report/presentation/widget/transport/accept_report_death_screen.dart';
import 'package:mortuary/features/processing_unit_report/presentation/get/processing_unit_controller.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/styles/colors.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../../core/widgets/load_more_listview.dart';
import '../../../../death_report/domain/enities/death_report_list_reponse.dart';


class DeathReportListScreen extends StatefulWidget {
  final UserRole userRole;

  const DeathReportListScreen({Key? key, required this.userRole})
      : super(key: key);

  @override
  State<DeathReportListScreen> createState() => _DeathReportListScreenState();
}

class _DeathReportListScreenState extends State<DeathReportListScreen> {
  int listCount = 50;
  int listPageCount = 0;
  List<DeathReportListResponse> paginatedList = [];
  List<DeathReportListResponse> allReportsList = [];
  List<DeathReportListResponse> filteredList = [];


  bool hasAnyNotificationAlert = false;
  DeathReportAlert? deathReportAlert;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      var controller = Get.find<ProcessingUnitController>();
      controller.getDeathReportList(widget.userRole).then((value) {
        allReportsList = value;
        getPaginatedList();
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProcessingUnitController>(
        initState:
        Get.find<ProcessingUnitController>().setUserRole(widget.userRole),
        builder: (controller) {
      return CustomScreenWidget(
          titleText: AppStrings.deathReportList.toUpperCase(),
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          /*  GestureDetector(
              onTap: () {
                setState(() {
                  //hasAnyNotificationAlert = false;
                });
                Go.to(() => AcceptDeathAlertScreen(
                      dataModel: deathReportAlert!,
                      userRole: widget.userRole,
                      onReportHistoryButton: () {
                        controller.getDeathReportList(widget.userRole);
                      },
                    ));
              },
              child: Visibility(
                  visible: hasAnyNotificationAlert,
                  child: Card(
                    elevation: 5,
                    semanticContainer: false,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(13),
                        child: Row(
                          children: [
                            sizeHorizontalFieldMediumPlaceHolder,
                            SvgPicture.asset(AppAssets.icDeathAlert),
                            sizeHorizontalFieldMediumPlaceHolder,
                            Expanded(
                              child: Column(
                                children: [
                                  CustomTextWidget(
                                    text:
                                        "${AppStrings.deathAlertAt}${deathReportAlert?.address}",
                                    colorText: Colors.black,
                                    size: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  sizeFieldMinPlaceHolder,
                                  Row(
                                    children: [
                                      SvgPicture.asset(AppAssets.icLoc),
                                       CustomTextWidget(
                                        text: deathReportAlert!.distance,
                                        colorText: AppColors.secondaryTextColor,
                                        size: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      sizeHorizontalFieldLargePlaceHolder,
                                      SvgPicture.asset(AppAssets.icClock),
                                       CustomTextWidget(
                                        text: deathReportAlert!.duration ,
                                        colorText: AppColors.secondaryTextColor,
                                        size: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )),
            ),*/
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextField(
                    suffixIcon: const Icon(Icons.search),
                    borderEnable: true,
                    text: AppStrings.search,
                    fontWeight: FontWeight.normal,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        filterSearchResults(value);
                      } else {
                        setState(() {
                          paginatedList = filteredList;
                        });
                      }
                    },
                  ),
                ),
                sizeFieldMinPlaceHolder,
            SizedBox(
              height: Get.height * 0.8,
              child: RefreshIndicator(
                onRefresh: () => controller.getDeathReportList(widget.userRole),
                child: controller.deathReportList.isEmpty &&
                        controller.isApiResponseLoaded == false
                    ? const Center(
                        child: CustomTextWidget(
                          text: ApiMessages.dataNotFound,
                          size: 18,
                        ),
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
                                height: Get.height * 0.42,
                                child: ReportListItem(listItem: listItem,userRole:widget.userRole,));
                          },
                        ),
                      ).wrapWithListViewSkeleton(
                        controller.isApiResponseLoaded),
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
      filteredList = paginatedList;
      listPageCount++;
    });
  }


  void filterSearchResults(String query) {
    List<DeathReportListResponse> searchResult = allReportsList
        .where((item) =>
    item.idNumber.toLowerCase().contains(query.toLowerCase()) ||
        item.bandCode.toLowerCase().contains(query.toLowerCase()))
        .toList();

    setState(() {
      paginatedList = searchResult;
    });
  }
}
