import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mortuary/core/constants/app_assets.dart';
import 'package:mortuary/core/constants/place_holders.dart';
import 'package:mortuary/core/error/errors.dart';
import 'package:mortuary/core/popups/show_popups.dart';
import 'package:mortuary/core/styles/colors.dart';
import 'package:mortuary/core/utils/utils.dart';
import 'package:mortuary/core/widgets/button_widget.dart';
import 'package:mortuary/core/widgets/custom_screen_widget.dart';
import 'package:mortuary/core/widgets/custom_text_widget.dart';
import 'package:mortuary/features/death_report/builder_ids.dart';
import 'package:mortuary/features/death_report/domain/enities/death_report_alert.dart';
import 'package:mortuary/features/death_report/domain/enities/processing_center.dart';
import 'package:mortuary/features/death_report/presentation/get/death_report_controller.dart';
import 'package:mortuary/features/death_report/presentation/widget/transport/processing_centers_list.dart';
import 'package:mortuary/features/google_map/google_map_view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/constants/app_strings.dart';
import '../../../../google_map/builder_ids.dart';
import '../../../../google_map/get/google_map_controller.dart';

class DropProcessUnitMapScreen extends StatefulWidget {
  final ProcessingCenter dataModel;
  final int deathReportId;
  final int deathCaseID;

  const DropProcessUnitMapScreen(
      {Key? key, required this.dataModel, required this.deathReportId , required this.deathCaseID})
      : super(key: key);

  @override
  State<DropProcessUnitMapScreen> createState() =>
      _DropProcessUnitMapScreenState();
}

class _DropProcessUnitMapScreenState extends State<DropProcessUnitMapScreen> {
  late ProcessingUser processingUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.dataModel.processingUsers.isNotEmpty) {
      processingUser = widget.dataModel.processingUsers.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeathReportController>(
        id: updateDeathReportScreen,
        builder: (controller) {
          return CustomScreenWidget(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              titleText: AppStrings.processCenterLoc.toUpperCase(),
              children: [
                sizeFieldMinPlaceHolder,
                Container(
                  height: Get.height * 0.4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: GoogleMapViewWidget(
                      didShowDirectionButton: true,
                      showDestinationPolyLines: true,
                      destinationPoints: LatLng(widget.dataModel.latitude,
                          widget.dataModel.longitude),
                    ),
                  ),
                ),
                sizeFieldLargePlaceHolder,
                Row(
                  children: [
                    // SvgPicture.asset(AppAssets.icProcessingUnitLoc),
                    sizeHorizontalFieldMediumPlaceHolder,
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          createInfoRow(AppAssets.icProcessingUnitLoc,
                              widget.dataModel.centreName, ""),
                          createInfoRow(AppAssets.icLocation,
                              AppStrings.address, widget.dataModel.address),
                        ],
                      ),
                    )
                  ],
                ),
                sizeFieldMediumPlaceHolder,
                GetBuilder<GoogleMapScreenController>(
                    id:updateGoogleMapScreen,
                    builder: (googleController) {
                      return Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(AppAssets.icLoc),
                            sizeHorizontalMinPlaceHolder,
                            CustomTextWidget(
                              text: googleController.distance,
                              colorText: AppColors.secondaryTextColor,
                              size: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            sizeHorizontalFieldLargePlaceHolder,
                            SvgPicture.asset(AppAssets.icClock),
                            sizeHorizontalMinPlaceHolder,
                            CustomTextWidget(
                              text: googleController.travelTime,
                              colorText: AppColors.secondaryTextColor,
                              size: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                      );
                    }
                ),
                sizeFieldLargePlaceHolder,
                GestureDetector(
                  onTap: () {
                    if (widget.dataModel.processingUsers.isNotEmpty) {
                      showRadioOptionDialog(
                          context,
                          AppStrings.generalLocation,
                          widget.dataModel.processingUsers,
                          processingUser,
                          (onChanged) => processingUser, (onConfirmed) {
                        setState(() {
                          processingUser = onConfirmed!;
                          openDialPad(context,processingUser.phoneNo);
                        });
                      }, (itemToString) => itemToString.name);
                    } else {
                      showSnackBar(context, "No contact number exits");
                    }
                    //
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(AppAssets.icPhoneCall),
                      sizeHorizontalMinPlaceHolder,
                      const CustomTextWidget(
                        text: AppStrings.callVolunteer,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
                sizeFieldMinPlaceHolder,
                ButtonWidget(
                  text: AppStrings.arrived,
                  buttonType: ButtonType.gradient,
                  isLoading: controller.isApiResponseLoaded,
                  icon: SvgPicture.asset(AppAssets.icTick),
                  onPressed: () {
                    controller.dropBodyToProcessingUnitByTransport(
                    deathReportId: widget.deathReportId,
                    deathCaseId: widget.deathCaseID,
                    processingUnitID: widget.dataModel.processingCenterId);
                  },
                ),
                sizeFieldLargePlaceHolder,
              ]);
        });
  }

  createInfoRow(String assets, String title, String body) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        SvgPicture.asset(assets),
        sizeHorizontalMinPlaceHolder,
        CustomTextWidget(
          text: title,
          colorText: AppColors.hexToColor("#667085"),
          fontWeight: FontWeight.w500,
          size: 14,
        ),
        sizeHorizontalMinPlaceHolder,
        Flexible(
          child: CustomTextWidget(
            text: body,
            colorText: AppColors.hexToColor("#AEAEAE"),
            size: 14,
          ),
        ),
      ],
    );
  }

}
