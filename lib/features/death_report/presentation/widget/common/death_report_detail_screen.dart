import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mortuary/core/constants/api_messages.dart';
import 'package:mortuary/core/constants/app_assets.dart';
import 'package:mortuary/core/constants/place_holders.dart';
import 'package:mortuary/core/enums/enums.dart';
import 'package:mortuary/core/utils/widget_extensions.dart';
import 'package:mortuary/core/widgets/custom_expansion_tile.dart';
import 'package:mortuary/core/widgets/custom_screen_widget.dart';
import 'package:mortuary/core/widgets/custom_text_widget.dart';
import 'package:mortuary/features/death_report/domain/enities/death_report_alert.dart';
import 'package:mortuary/features/death_report/domain/enities/death_report_detail_response.dart';
import 'package:mortuary/features/death_report/presentation/components/report_list_component.dart';
import 'package:mortuary/features/death_report/presentation/get/death_report_controller.dart';
import 'package:mortuary/features/death_report/presentation/widget/transport/accept_report_death_screen.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/styles/colors.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../../core/widgets/load_more_listview.dart';
import '../../../../processing_unit_report/builder_ids.dart';
import '../../../domain/enities/death_report_list_reponse.dart';

class DeathReportDetailScreen extends StatefulWidget {
  final UserRole userRole;
  final int reportId;

  const DeathReportDetailScreen({Key? key, required this.userRole, required this.reportId}) : super(key: key);

  @override
  State<DeathReportDetailScreen> createState() => _DeathReportDetailScreenState();
}

class _DeathReportDetailScreenState extends State<DeathReportDetailScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      var controller = Get.find<DeathReportController>();
      controller.getDetailOfReport(widget.userRole, widget.reportId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeathReportController>(
        id: updateDeathReportScreen,
        builder: (controller) {
          return CustomScreenWidget(
              titleText: AppStrings.detailReport.toUpperCase(),
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: controller.deathReportDetailResponse != null
                      ? Column(
                          children: [
                            CustomExpansionTile(tileText: AppStrings.alertDetail, children: [
                              controller.deathReportDetailResponse!.alerts !=null?
                              alertDetailTileComponent(controller.deathReportDetailResponse!.alerts!)
                                  : Container(height: 100,
                              child: CustomTextWidget(text: ApiMessages.dataNotFound,),),
                            ]),


                            sizeFieldMediumPlaceHolder,

                            CustomExpansionTile(tileText: AppStrings.emergencyDetail, children: [
                              controller.deathReportDetailResponse!.emergency !=null?
                              emergencyDetailTileComponent(controller.deathReportDetailResponse!.emergency!)
                                  : Container(height: 100,
                                child: CustomTextWidget(text: ApiMessages.dataNotFound,),),
                            ]),
                            sizeFieldMediumPlaceHolder,

                            CustomExpansionTile(tileText: AppStrings.morgueDetail, children: [
                              controller.deathReportDetailResponse!.morgue !=null?
                              expansionTileComponent(controller.deathReportDetailResponse!.alerts!)
                                  : Container(height: 100,
                                child: CustomTextWidget(text: ApiMessages.dataNotFound,),),
                            ]),
                            sizeFieldMediumPlaceHolder,

                            CustomExpansionTile(tileText: AppStrings.documents, children: [
                              controller.deathReportDetailResponse!.attachments.isNotEmpty?
                              expansionTileComponent(controller.deathReportDetailResponse!.alerts!)
                                  : Container(height: 100,
                                child: CustomTextWidget(text: ApiMessages.dataNotFound,),),
                            ]),

                          ],
                        )
                      : const Center(
                          child: CustomTextWidget(
                          text: ApiMessages.dataNotFound,
                        )),
                ).wrapWithLoadingBool(controller.isApiResponseLoaded)
              ]);
        });
  }



  Widget alertDetailTileComponent(DeathAlertDetail alertDetail)
  {
    return  Table(
      children: [
        tableComponent(AppAssets.icQR,AppStrings.qrNumber,alertDetail.bandCode),
        rowSpaces(),
        tableComponent(AppAssets.icIDType,AppStrings.idType,alertDetail.visaType),
        rowSpaces(),
        tableComponent(AppAssets.icIDNumber,AppStrings.idNumber,alertDetail.idNumber),
        rowSpaces(),
        tableComponent(AppAssets.icNationality,AppStrings.nationality,alertDetail.nationality),
        rowSpaces(),
        tableComponent(AppAssets.icGender,AppStrings.gender,alertDetail.gender),
        rowSpaces(),
        tableComponent(AppAssets.icAge,AppStrings.age,alertDetail.age),
        rowSpaces(),
        tableComponent(AppAssets.icAge,AppStrings.ageGroup,alertDetail.ageGroup),
        rowSpaces(),
        tableComponent(AppAssets.icDeathType,AppStrings.deathType,alertDetail.deathType),
        rowSpaces(),
        tableComponent(AppAssets.icAddress,AppStrings.generalLocation,alertDetail.generalizeLocation),
        rowSpaces(),
        tableComponent(AppAssets.icDate,AppStrings.date,convertAppStyleDate(alertDetail.reportDate)),
        rowSpaces(),
        tableComponent(AppAssets.icTime,AppStrings.time,alertDetail.reportTime),
        rowSpaces(),
        tableComponent(AppAssets.icAddress,AppStrings.address,alertDetail.address),
        rowSpaces(),

      ]);
  }


  Widget emergencyDetailTileComponent(EmergencyDetail alertDetail)
  {
    return  Table(
        children: [
          tableComponent(AppAssets.icQR,AppStrings.qrNumber,alertDetail.bandCode),
          rowSpaces(),
          tableComponent(AppAssets.icIDType,AppStrings.idType,alertDetail.visaType),
          rowSpaces(),
          tableComponent(AppAssets.icIDNumber,AppStrings.idNumber,alertDetail.idNumber),
          rowSpaces(),
          tableComponent(AppAssets.icNationality,AppStrings.nationality,alertDetail.nationality),
          rowSpaces(),
          tableComponent(AppAssets.icGender,AppStrings.gender,alertDetail.gender),
          rowSpaces(),
          tableComponent(AppAssets.icAge,AppStrings.age,alertDetail.age),
          rowSpaces(),
          tableComponent(AppAssets.icAge,AppStrings.ageGroup,alertDetail.ageGroup),
          rowSpaces(),
          tableComponent(AppAssets.icDeathType,AppStrings.deathType,alertDetail.deathType),
          rowSpaces(),
          tableComponent(AppAssets.icAddress,AppStrings.generalLocation,alertDetail.generalizeLocation),
          rowSpaces(),
          tableComponent(AppAssets.icDate,AppStrings.date,convertAppStyleDate(alertDetail.reportDate)),
          rowSpaces(),
          tableComponent(AppAssets.icTime,AppStrings.time,alertDetail.reportTime),
          rowSpaces(),
          tableComponent(AppAssets.icAddress,AppStrings.address,alertDetail.address),
          rowSpaces(),

        ]);
  }





  TableRow tableComponent(String icon, String title, String value) {
    return TableRow(children: [
      Row(
        children: [
          SvgPicture.asset(icon),
          sizeHorizontalFieldMinPlaceHolder,
          Expanded(
            child: CustomTextWidget(
              text: title,
              colorText: AppColors.secondaryTextColor,
            ),
          ),
        ],
      ),
      CustomTextWidget(text: value, colorText: Colors.grey),
    ]);
  }

  TableRow rowSpaces() {
    return const TableRow(children: [
      SizedBox(
        height: 5,
      ),
      SizedBox(
        height: 5,
      ),
    ]);
  }
}
