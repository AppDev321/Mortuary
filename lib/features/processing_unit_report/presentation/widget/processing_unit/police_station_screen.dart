import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:mortuary/core/constants/app_assets.dart';
import 'package:mortuary/core/constants/place_holders.dart';
import 'package:mortuary/core/popups/show_popups.dart';
import 'package:mortuary/core/styles/colors.dart';
import 'package:mortuary/core/utils/utils.dart';
import 'package:mortuary/core/utils/validators.dart';
import 'package:mortuary/core/widgets/custom_screen_widget.dart';
import 'package:mortuary/core/widgets/custom_text_widget.dart';
import 'package:mortuary/features/authentication/presentation/component/gender_option_widget.dart';
import 'package:mortuary/features/document_upload/presentation/widget/document_upload_screen.dart';
import 'package:mortuary/features/processing_unit_report/presentation/get/processing_unit_controller.dart';

import '../../../../../core/constants/api_messages.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/enums/enums.dart';
import '../../../../../core/utils/app_config_service.dart';
import '../../../../../core/widgets/button_widget.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../core/widgets/dashed_line.dart';
import '../../../../country_picker/functions.dart';
import '../../../../document_upload/domain/entity/attachment_type.dart';
import '../../../../splash/domain/entities/splash_model.dart';
import 'death_report_form.dart';

class PoliceStationScreen extends StatefulWidget {
  final int deathBodyBandCode;
  final int deathFormCode;
  final bool isBodyReceivedFromAmbulance;
  final List<AttachmentType> attachmentList;
  final List<Station> policeStationList;

  PoliceStationScreen({
    Key? key,
    required this.deathBodyBandCode,
    required this.deathFormCode,
    required this.isBodyReceivedFromAmbulance,
    List<AttachmentType>? attachmentList, required this.policeStationList,
  })  : this.attachmentList = attachmentList ?? [],
        // Assign default value here
        super(key: key);

  @override
  State<PoliceStationScreen> createState() => _PoliceStationScreenState();
}

class _PoliceStationScreenState extends State<PoliceStationScreen> {
  var policeStationFormKey = GlobalKey<FormState>();

  TextEditingController policeStationTextController = TextEditingController();
  List<CheckedBoxItem> pocItemList = [];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProcessingUnitController>(builder: (controller) {
      return Form(
        key: policeStationFormKey,
        child: CustomScreenWidget(titleText: AppStrings.policeStation.toUpperCase(), crossAxisAlignment: CrossAxisAlignment.center, children: [
          const CustomTextWidget(
            text: AppStrings.policeFormDesc,
            size: 13,
            colorText: AppColors.secondaryTextColor,
            textAlign: TextAlign.center,
          ),
          sizeFieldLargePlaceHolder,
          CustomTextField(
            controller: policeStationTextController,
            suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
            headText: AppStrings.policeStation,
            borderEnable: true,
            text: AppStrings.policeStation,
            validator: EmptyFieldValidator.validator,
            fontWeight: FontWeight.normal,
            readOnly: true,
            onTap: () {
              showRadioOptionDialog(context, AppStrings.selectPoliceStation, widget.policeStationList, controller.selectedPoliceStation,
                  (onChanged) => controller.selectedPoliceStation, (onConfirmed) {
                controller.setPoliceStation(onConfirmed!);
                controller.update();
                policeStationTextController.text = controller.selectedPoliceStation?.name ?? "";
                setState(() {
                  pocItemList.clear();
                  pocItemList = List.generate(onConfirmed.pocs.length, (index) => CheckedBoxItem(onConfirmed.pocs[index], true));
                });
              }, (itemToString) => itemToString?.name ?? "");
            },
          ),
          controller.selectedPoliceStation != null ? representativesView(context, pocItemList) : sizeFieldMinPlaceHolder,
          sizeFieldLargePlaceHolder,
          ButtonWidget(
            isLoading: controller.isApiResponseLoaded,
            text: AppStrings.next,
            buttonType: ButtonType.gradient,
            textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            onPressed: () {
              if (policeStationFormKey.currentState!.validate()) {
                controller.updatePoliceStation(
                    widget.deathBodyBandCode.toString(), controller.selectedPoliceStation!.id, widget.deathFormCode, getCheckedStations(pocItemList),
                    () {
                  if (widget.isBodyReceivedFromAmbulance) {
                    Get.off(() => DocumentUploadScreen(
                        currentUserRole: UserRole.emergency, bandCodeId: widget.deathBodyBandCode, attachmentsTypes: widget.attachmentList));
                  } else {
                    Go.to(() => PUDeathReportFormScreen(deathBodyBandCode: widget.deathBodyBandCode, deathFormCode: widget.deathFormCode));
                  }
                });
              }
            },
          ),
          sizeFieldMediumPlaceHolder,
        ]),
      );
    });
  }

  Widget representativesView(BuildContext context, List<CheckedBoxItem> listPocs) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sizeFieldMediumPlaceHolder,
        Align(
          alignment: Alignment.centerLeft,
          child: CustomTextWidget(
            text: AppStrings.policeRepresentative,
            fontWeight: FontWeight.w600,
            textAlign: TextAlign.start,
            size: 16,
          ),
        ),
        sizeFieldMediumPlaceHolder,
        listPocs.isNotEmpty
            ? Column(
                children: [
                  ...listPocs.map((e) {
                    return rowItem(context, e);
                  }).toList()
                ],
              )
            : const Center(child: CustomTextWidget(text: ApiMessages.dataNotFound))
      ],
    );
  }

  Widget rowItem(BuildContext context, CheckedBoxItem item) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              // SvgPicture.asset(AppAssets.icPoliceCheckBox),
              Checkbox(
                value: item.isChecked,
                onChanged: (value) {
                  setState(() {
                    pocItemList.firstWhere((element) => element.stationPoc.id == item.stationPoc.id).isChecked = !item.isChecked;
                  });
                },
                activeColor: Colors.green,
                tristate: false,
              ),
              sizeHorizontalFieldMinPlaceHolder,
              Expanded(
                child: Table(
                  children: [
                    TableRow(children: [
                      Row(
                        children: [
                          SvgPicture.asset(AppAssets.icPerson),
                          sizeHorizontalFieldMinPlaceHolder,
                          const CustomTextWidget(
                            text: AppStrings.name,
                            colorText: AppColors.secondaryTextColor,
                          ),
                        ],
                      ),
                      CustomTextWidget(text: item.stationPoc.name, colorText: Colors.grey),
                    ]),
                    TableRow(children: [
                      sizeFieldMinPlaceHolder,
                      sizeFieldMinPlaceHolder,
                    ]),
                    TableRow(children: [
                      Row(
                        children: [
                          SvgPicture.asset(AppAssets.icTelephone),
                          sizeHorizontalFieldMinPlaceHolder,
                          const CustomTextWidget(text: AppStrings.contact, colorText: AppColors.secondaryTextColor),
                        ],
                      ),
                      GestureDetector(
                          onTap: () {
                            openDialPad(context, item.stationPoc.contactNo);
                          },
                          child: CustomTextWidget(text: item.stationPoc.contactNo, colorText: Colors.grey)),
                    ])
                  ],
                ),
              )
            ],
          ),
          sizeFieldMediumPlaceHolder,
          const DashedLineSeprator(
            color: AppColors.secondaryTextColor,
          ) // Add vertical space if needed
        ],
      ),
    );
  }

  List<int> getCheckedStations(List<CheckedBoxItem> checkedBoxItems) {
    return checkedBoxItems.where((checkedBoxItem) => checkedBoxItem.isChecked).map((checkedBoxItem) => checkedBoxItem.stationPoc.id).toList();
  }
}

class CheckedBoxItem {
  StationPoc stationPoc;
  bool isChecked;

  CheckedBoxItem(this.stationPoc, this.isChecked);
}
