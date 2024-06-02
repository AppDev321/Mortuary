import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mortuary/core/constants/app_assets.dart';
import 'package:mortuary/core/constants/place_holders.dart';
import 'package:mortuary/core/styles/colors.dart';
import 'package:mortuary/core/widgets/button_widget.dart';
import 'package:mortuary/core/widgets/custom_text_widget.dart';
import 'package:mortuary/features/death_report/domain/enities/processing_center.dart';
import 'package:mortuary/features/death_report/presentation/get/death_report_controller.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/utils.dart';
import '../../domain/enities/death_report_list_reponse.dart';
import '../widget/transport/drop_process_unit_map_view.dart';

class ProcessingCenterRowItemWidget extends StatefulWidget {
  final ProcessingCenter listItem;
  final int deathReportId;
  final int deathCaseId;

  const ProcessingCenterRowItemWidget(
      {Key? key, required this.listItem, required this.deathReportId, required this.deathCaseId})
      : super(key: key);

  @override
  State<ProcessingCenterRowItemWidget> createState() => _ProcessingCenterRowItemWidgetState();
}

class _ProcessingCenterRowItemWidgetState extends State<ProcessingCenterRowItemWidget> {

  bool isApiLoading = false;


  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeathReportController>(
      builder: (controller) {
        return Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: AppColors.secondaryTextColor, width: 1)),
          child: Row(
            children: [
              SvgPicture.asset(AppAssets.icProcessingUnit),
              sizeHorizontalFieldMediumPlaceHolder,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextWidget(
                      text: widget.listItem.centreName,
                      fontWeight: FontWeight.w700,
                      colorText: Colors.black,
                    ),
                    CustomTextWidget(
                        text: widget.listItem.address,
                        fontWeight: FontWeight.w500,
                        colorText: AppColors.secondaryTextColor),
                    sizeFieldMinPlaceHolder,
                    Row(
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
                    sizeFieldMinPlaceHolder,
                    createInfoRow(AppAssets.icBedSpace, AppStrings.availableSpace,
                        "${widget.listItem.availableSpace}"),
                    sizeFieldMinPlaceHolder,
                    ButtonWidget(
                      isLoading: isApiLoading,
                      text: AppStrings.select,
                      icon: SvgPicture.asset(AppAssets.icTick),
                      buttonType: ButtonType.gradient,
                      onPressed: () async{
                        setState(() {
                          isApiLoading = true;
                        });

                        ProcessingCenter? processingCenter = await controller.getDetailOfProcessUnit(
                            widget.deathReportId,
                            widget.listItem.processingCenterId,
                            widget.deathCaseId);


                        if (processingCenter != null) {
                          Go.to(() => DropProcessUnitMapScreen(
                            dataModel: processingCenter,
                            deathReportId: widget.deathReportId,
                            deathCaseID:  widget.deathCaseId,
                          ));
                        }

                        setState(() {
                          isApiLoading = false;
                        });

                    },
                    )
                  ],
                ),
              )
            ],
          ),
        );
      }
    );
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
