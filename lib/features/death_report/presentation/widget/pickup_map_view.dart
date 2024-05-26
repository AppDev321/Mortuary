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
import 'package:mortuary/features/death_report/domain/enities/death_report_alert.dart';
import 'package:mortuary/features/death_report/domain/enities/processing_center.dart';
import 'package:mortuary/features/death_report/presentation/get/death_report_controller.dart';
import 'package:mortuary/features/death_report/presentation/widget/processing_centers_list.dart';
import 'package:mortuary/features/google_map/google_map_view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/app_strings.dart';

class PickupMapScreen extends StatelessWidget {
  final DeathReportAlert dataModel;
  const PickupMapScreen({Key? key, required this.dataModel}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeathReportController>(
        initState: (_) {
          // Use a function to initialize the state
          Get.find<DeathReportController>().transportScannedBodyCount = int.parse(dataModel.noOfDeaths);
        }, builder: (controller) {
        return CustomScreenWidget(
          crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            titleText: AppStrings.pickupMapLoc.toUpperCase(),
            children: [
              const CustomTextWidget(text: AppStrings.pickupMapLabel,colorText: AppColors.secondaryTextColor,textAlign: TextAlign.center,),
              sizeFieldMinPlaceHolder,
              Container(
                height: Get.height * 0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: GoogleMapViewWidget(didShowDirectionButton: true,showDestinationPolyLines: true,
                  destinationPoints: LatLng(dataModel.latitude,dataModel.longitude),),
                ),
              ),
            sizeFieldLargePlaceHolder,

            Row(
              children: [
                SvgPicture.asset(AppAssets.icVolunteerLoc),
                sizeHorizontalFieldMediumPlaceHolder,
               Flexible(
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   mainAxisAlignment: MainAxisAlignment.start,
                   children: [
                   createInfoRow(AppAssets.icPerson,"${AppStrings.noOfDeath}:", dataModel.noOfDeaths),
                     createInfoRow(AppAssets.icCalender,AppStrings.date, dataModel.reportDate),
                     createInfoRow(AppAssets.icTime,AppStrings.time, dataModel.reportTime),
                     createInfoRow(AppAssets.icLocation,AppStrings.generalLocation,dataModel.generalLocation),
                     createInfoRow(AppAssets.icCalender,AppStrings.address, dataModel.address ??"N/A")
                 ],),
               )
              ],
            ),
        sizeFieldMediumPlaceHolder,
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(AppAssets.icLoc),
                    sizeHorizontalMinPlaceHolder,
                    const CustomTextWidget(
                      text: "10Km",
                      colorText: AppColors.secondaryTextColor,
                      size: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    sizeHorizontalFieldLargePlaceHolder,
                    SvgPicture.asset(AppAssets.icClock),
                    sizeHorizontalMinPlaceHolder,
                    const CustomTextWidget(
                      text: "23 min",
                      colorText: AppColors.secondaryTextColor,
                      size: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
              sizeFieldLargePlaceHolder,
              GestureDetector(
                onTap: (){
                  openDialPad(context,dataModel.volunteerContactNumber);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(AppAssets.icPhoneCall),
                    sizeHorizontalMinPlaceHolder,
                    const CustomTextWidget(text: AppStrings.callVolunteer,fontWeight: FontWeight.bold,),
                  ],
                ),
              ),
              sizeFieldMinPlaceHolder,
              ButtonWidget(text: AppStrings.arrived, buttonType: ButtonType.gradient,
               icon: SvgPicture.asset(AppAssets.icTick),
              onPressed: (){
                controller.showQRCodeScannerScreen(
                  onApiCallBack: (data){
                  print("Api call backed success ==>> ${controller.transportScannedBodyCount}");
                  if(controller.transportScannedBodyCount > 1) {
                    controller.transportScannedBodyCount--;
                    var dataDialog = GeneralError(
                        message: AppStrings.scanNextBody,
                        title: AppStrings.scanSuccess
                    );
                    showAppThemedDialog(dataDialog,showErrorMessage: false);
                  }
                  else
                    {

                      var list = List<ProcessingCenter>.from(data.map((x) => ProcessingCenter.fromJson(x)));
                      list.add(list[0]);
                      list.add(list[0]);
                      list.add(list[0]);  list.add(list[0]);
                      list.add(list[0]);
                      list.add(list[0]);  list.add(list[0]);
                      list.add(list[0]);

                      print(list.length);

                      Go.to(()=>ProcessingUnitListScreen(processingCenters: list,deathReportId: dataModel.deathReportId,));
                    }
                });
              },
              ),
              sizeFieldLargePlaceHolder,

            ]);
      }
    );
  }
  
  createInfoRow(String assets, String title, String body) {
    return  Row(
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

  openDialPad(BuildContext context,String phoneNumber) async {
    Uri url = Uri(scheme: "tel", path: phoneNumber);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
     showSnackBar(context, "Unable to open dial pad");
    }
  }

}
