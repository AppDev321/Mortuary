import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mortuary/core/constants/api_messages.dart';
import 'package:mortuary/core/constants/app_assets.dart';
import 'package:mortuary/core/constants/place_holders.dart';
import 'package:mortuary/core/enums/enums.dart';
import 'package:mortuary/core/widgets/custom_expansion_tile.dart';
import 'package:mortuary/core/widgets/custom_screen_widget.dart';
import 'package:mortuary/core/widgets/custom_text_widget.dart';
import 'package:mortuary/features/death_report/domain/enities/death_report_detail_response.dart';
import 'package:mortuary/features/death_report/presentation/get/death_report_controller.dart';

import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/styles/colors.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../../event_bus.dart';
import '../../../../document_upload/domain/entity/attachment_type.dart';
import '../../../../document_upload/init_upload.dart';
import '../../../../document_upload/presentation/widget/document_upload_screen.dart';
import '../../../../processing_unit_report/builder_ids.dart';

class DeathReportDetailScreen extends StatefulWidget {
  final UserRole userRole;
  final int reportId;

  const DeathReportDetailScreen({Key? key, required this.userRole, required this.reportId}) : super(key: key);

  @override
  State<DeathReportDetailScreen> createState() => _DeathReportDetailScreenState();
}

class _DeathReportDetailScreenState extends State<DeathReportDetailScreen> {
  late StreamSubscription streamSubscription;
  @override
  void initState() {
    super.initState();

      WidgetsBinding.instance.addPostFrameCallback((_) {
      var controller = Get.find<DeathReportController>();
      controller.getDetailOfReport(widget.userRole, widget.reportId);

      streamSubscription = eventBus.on<RefreshDetailReportScreen>().listen((event) {
        if (mounted) {
          controller.getDetailOfReport(widget.userRole, widget.reportId);
        }
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeathReportController>(
        id: updateDeathReportScreen,
        builder: (controller) {
          return CustomScreenWidget(titleText: AppStrings.detailReport.toUpperCase(), crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
            controller.isApiResponseLoaded
                ? SizedBox(height: Get.height,child: const Center(child: CircularProgressIndicator(),),)
                : Container(
                  child: controller.deathReportDetailResponse != null
                  ? Column(
                      children: [
                        CustomExpansionTile(tileText: AppStrings.alertDetail, children: [
                          controller.deathReportDetailResponse!.alerts != null ? alertDetailTileComponent(controller.deathReportDetailResponse!.alerts!) : noDataContainer(),
                        ]),
                        sizeFieldMediumPlaceHolder,
                        CustomExpansionTile(tileText: AppStrings.transportDetail, children: [
                          controller.deathReportDetailResponse!.transport != null ? transportDetailTileComponent(controller.deathReportDetailResponse!.transport!) : noDataContainer(),
                        ]),
                        sizeFieldMediumPlaceHolder,
                        CustomExpansionTile(tileText: AppStrings.emergencyDetail, children: [
                          controller.deathReportDetailResponse!.emergency != null ? emergencyDetailTileComponent(controller.deathReportDetailResponse!.emergency!) : noDataContainer(),
                        ]),
                        sizeFieldMediumPlaceHolder,
                        CustomExpansionTile(tileText: AppStrings.morgueDetail, children: [
                          controller.deathReportDetailResponse!.morgue != null ? morgueDetailTileComponent(controller.deathReportDetailResponse!.morgue!) : noDataContainer(),
                        ]),
                        sizeFieldMediumPlaceHolder,
                        CustomExpansionTile(tileText: AppStrings.documents, children: [
                          controller.deathReportDetailResponse!.attachments.isNotEmpty
                              ? attachmentsDetailTileComponent(controller.deathReportDetailResponse!.alerts!.bandCodeId, controller.deathReportDetailResponse!.attachments)
                              : noDataContainer(),
                        ]),
                      ],
                    )
                  : SizedBox(
                    height:  Get.height,
                    child: const Center(
                        child: CustomTextWidget(
                        text: ApiMessages.dataNotFound,
                      )),
                  ),
            )
          ]);
        });
  }

  Widget alertDetailTileComponent(DeathAlertDetail alertDetail) {
    return Table(children: [
      tableComponent(AppAssets.icQR, AppStrings.qrNumber, alertDetail.bandCode),
      rowSpaces(),
      tableComponent(AppAssets.icIDType, AppStrings.idType, alertDetail.visaType),
      rowSpaces(),
      tableComponent(AppAssets.icIDNumber, AppStrings.idNumber, alertDetail.idNumber),
      rowSpaces(),
      tableComponent(AppAssets.icNationality, AppStrings.nationality, alertDetail.nationality),
      rowSpaces(),
      tableComponent(AppAssets.icGender, AppStrings.gender, alertDetail.gender),
      rowSpaces(),
      tableComponent(AppAssets.icAge, AppStrings.age, alertDetail.age),
      rowSpaces(),
      tableComponent(AppAssets.icAge, AppStrings.ageGroup, alertDetail.ageGroup),
      rowSpaces(),
      tableComponent(AppAssets.icDeathType, AppStrings.deathType, alertDetail.deathType),
      rowSpaces(),
      tableComponent(AppAssets.icAddress, AppStrings.generalLocation, alertDetail.generalizeLocation),
      rowSpaces(),
      tableComponent(AppAssets.icDate, AppStrings.date, convertAppStyleDate(alertDetail.reportDate)),
      rowSpaces(),
      tableComponent(AppAssets.icTime, AppStrings.time, alertDetail.reportTime),
      rowSpaces(),
      tableComponent(AppAssets.icAddress, AppStrings.address, alertDetail.address),
    ]);
  }

  Widget transportDetailTileComponent(TransportDetail alertDetail) {
    return Table(children: [
      tableComponent(AppAssets.icDriver, AppStrings.driverName, alertDetail.driverName),
      rowSpaces(),
      tableComponent(AppAssets.icCall, AppStrings.contact, alertDetail.contactNo),
      rowSpaces(),
      tableComponent(AppAssets.icVehicle, AppStrings.email, alertDetail.email),
      rowSpaces(),
      tableComponent(AppAssets.icVehicle, AppStrings.vehicleNo, alertDetail.vehicleNo),
      rowSpaces(),
      tableComponent(AppAssets.icVehicle, AppStrings.capacity, alertDetail.bodyCapacity),
    ]);
  }

  Widget emergencyDetailTileComponent(EmergencyDetail alertDetail) {
    return Table(children: [
      tableComponent(AppAssets.icDepartment, AppStrings.emergencyDepartment, alertDetail.processingCenter),
      rowSpaces(),
      tableComponent(AppAssets.icGender, AppStrings.pocName, alertDetail.pocName),
      rowSpaces(),
      tableComponent(AppAssets.icCall, AppStrings.contact, alertDetail.pocPhone),
      rowSpaces(),
      tableComponent(AppAssets.icVehicle, AppStrings.email, alertDetail.pocEmail),
      rowSpaces(),
      tableComponent(AppAssets.icSpace, AppStrings.totalSpace, alertDetail.totalSpace),
      rowSpaces(),
      tableComponent(AppAssets.icSpace, AppStrings.availableSpace, alertDetail.availableSpace),
      rowSpaces(),
      tableComponent(AppAssets.icAddress, AppStrings.address, alertDetail.address),
      rowSpaces(),
      tableComponent(AppAssets.icGender, AppStrings.policeRepresentative, ""),
      rowSpaces(),
      tableComponent(AppAssets.icCall, AppStrings.contact, ""),
    ]);
  }

  Widget morgueDetailTileComponent(MorgueDetail alertDetail) {
    return Table(children: [
      tableComponent(AppAssets.icDepartment, AppStrings.morgueDepartment, alertDetail.processingCenter),
      rowSpaces(),
      tableComponent(AppAssets.icGender, AppStrings.pocName, alertDetail.pocName),
      rowSpaces(),
      tableComponent(AppAssets.icCall, AppStrings.contact, alertDetail.pocPhone),
      rowSpaces(),
      tableComponent(AppAssets.icVehicle, AppStrings.email, alertDetail.pocEmail),
      rowSpaces(),
      tableComponent(AppAssets.icSpace, AppStrings.totalSpace, alertDetail.totalSpace),
      rowSpaces(),
      tableComponent(AppAssets.icSpace, AppStrings.availableSpace, alertDetail.availableSpace),
      rowSpaces(),
      tableComponent(AppAssets.icAddress, AppStrings.address, alertDetail.address),
      rowSpaces(),
      tableComponent(AppAssets.icGender, AppStrings.policeRepresentative, ""),
      rowSpaces(),
      tableComponent(AppAssets.icCall, AppStrings.contact, ""),
    ]);
  }

  Widget attachmentsDetailTileComponent(int bandCodeId, List<AttachmentType> alertDetail) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: [
      ...alertDetail.map((attachment) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomTextWidget(
              text: attachment.type,
              colorText: AppColors.secondaryTextColor,
            ),
            const SizedBox(
              height: 3,
            ),
            attachment.path.isNotEmpty
                ? GestureDetector(
                    onTap: () async {
                      //  openUrl(context,attachment.path);
                      await showDialog(context: context, builder: (_) => imageDialog(attachment.type, attachment.path, context));
                    },
                    child: CustomTextWidget(
                      text: AppStrings.download,
                      colorText: AppColors.hexToColor("#72AB66"),
                      textDecoration: TextDecoration.underline,
                    ))
                : GestureDetector(
                    onTap: () async {
                      attachment.name = attachment.type;
                      if (widget.userRole == UserRole.emergency) {
                        await initUpload();
                        Go.to(() => DocumentUploadScreen(
                              closeOnlyDocumentScreen: true,
                              currentUserRole: widget.userRole,
                              attachmentsTypes: [attachment],
                              bandCodeId: bandCodeId,
                            ));
                      }
                    },
                    child: CustomTextWidget(
                      text: widget.userRole == UserRole.emergency ? AppStrings.clickToUpload : ApiMessages.dataNotFound,
                      colorText: AppColors.hexToColor("#72AB66"),
                      textDecoration: widget.userRole == UserRole.emergency ? TextDecoration.underline : null,
                    )),
            sizeFieldMediumPlaceHolder,
          ],
        );
      })
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

  noDataContainer() {
    return const SizedBox(
      height: 80,
      child: Center(
          child: CustomTextWidget(
        text: ApiMessages.dataNotFound,
      )),
    );
  }

  Widget imageDialog(text, path, context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
      ),
      backgroundColor: AppColors.blackColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 10, bottom: 10),
                  child: CustomTextWidget(
                    text: text,
                    fontWeight: FontWeight.w500,
                    size: 18,
                    colorText: Colors.white,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close_rounded),
                color: Colors.white,
              ),
            ],
          ),
          SizedBox(
            height: Get.height*0.7,
            child: Image.network(
              '$path',
              fit: BoxFit.fill,
              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
