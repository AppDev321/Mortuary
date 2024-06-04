import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
import 'package:mortuary/features/processing_unit_report/presentation/get/processing_unit_controller.dart';

import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/enums/enums.dart';
import '../../../../../core/utils/app_config_service.dart';
import '../../../../../core/widgets/button_widget.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../country_picker/functions.dart';
import '../../../../splash/domain/entities/splash_model.dart';

class PUDeathReportFormScreen extends StatefulWidget {
  final int deathBodyBandCode;
  final int deathFormCode;
  final List<Station> policeStationsList;


  PUDeathReportFormScreen(
      {Key? key, required this.deathBodyBandCode, required this.deathFormCode, required this.policeStationsList})
      : super(key: key);

  @override
  State<PUDeathReportFormScreen> createState() => _PUDeathReportFormScreenState();
}

class _PUDeathReportFormScreenState extends State<PUDeathReportFormScreen> {
  List<Gender> genders = [];
  Gender? selectedGender;
  var puDeathReportFormKey = GlobalKey<FormState>();
  TextEditingController groupAgeTextController = TextEditingController();
  TextEditingController visaTypeTextController = TextEditingController();
  TextEditingController nationalityTextController = TextEditingController();
  TextEditingController deathTypeTextController = TextEditingController();



  @override
  void initState() {
    super.initState();
    genders.add(Gender(1, "Male", AppAssets.icMale, false));
    genders.add(Gender(2, "Female", AppAssets.icFemale, false));
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProcessingUnitController>(builder: (controller) {
      return Form(
        key: puDeathReportFormKey,
        child: CustomScreenWidget(
            titleText: AppStrings.reportDeath.toUpperCase(),
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomTextWidget(
                text: AppStrings.reportFormDesc,
                size: 13,
                colorText: AppColors.secondaryTextColor,
                textAlign: TextAlign.center,
              ),
              sizeFieldLargePlaceHolder,
              CustomTextField(
                headText: AppStrings.qrNumber,
                borderEnable: true,
                text: '${widget.deathBodyBandCode}',
                fontWeight: FontWeight.normal,
                readOnly: true,
              ),
              sizeFieldMinPlaceHolder,
              CustomTextField(
                controller: visaTypeTextController,
                suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
                headText: AppStrings.idType,
                borderEnable: true,
                text: AppStrings.idType,
                validator: EmptyFieldValidator.validator,
                fontWeight: FontWeight.normal,
                readOnly: true,
                onTap: () {
                  showRadioOptionDialog(
                      context,
                      AppStrings.selectVisaType,
                      ConfigService().getVisaTypes(),
                      controller.selectedVisaType,
                      (onChanged) => controller.selectedVisaType,
                      (onConfirmed) {
                    controller.setVisaType(onConfirmed!);
                    controller.update();
                    visaTypeTextController.text =
                        controller.selectedVisaType?.name ?? "";
                  }, (itemToString) => itemToString?.name ?? "");
                },
              ),
              sizeFieldMinPlaceHolder,
              CustomTextField(
                headText: AppStrings.idNumber,
                borderEnable: true,
                text: AppStrings.idNumber,
                validator: EmptyFieldValidator.validator,
                fontWeight: FontWeight.normal,
                onChanged: controller.setIdNumber,
              ),
              sizeFieldMinPlaceHolder,
              CustomTextField(
                controller: nationalityTextController,
                suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
                headText: AppStrings.nationality,
                borderEnable: true,
                text: AppStrings.nationality,
                validator: EmptyFieldValidator.validator,
                fontWeight: FontWeight.normal,
                readOnly: true,
                onTap: () async {
                  var country =  await showCountryPickerSheet(context,isFromApi: true,countryApiList: ConfigService().getCountries()
                  );
                  if(country != null ){
                    controller.setNationality(country!);
                    print(controller.selectedNationality);
                    nationalityTextController.text =
                        controller.selectedNationality?.nationality ?? "";
                    controller.update();
                  }

                },
              ),
              sizeFieldMinPlaceHolder,
              const Align(
                alignment: Alignment.topLeft,
                child: CustomTextWidget(
                    text: AppStrings.gender,
                    size: 13,
                    colorText: AppColors.blackColor),
              ),
              sizeFieldMinPlaceHolder,
              Row(
                children: [
                  ...genders.map((e) => InkWell(
                        splashColor: Colors.pinkAccent,
                        onTap: () {
                          setState(() {
                            genders
                                .forEach((gender) => gender.isSelected = false);
                            e.isSelected = true;

                            selectedGender = e;
                          });
                        },
                        child: CustomGenderRadio(e),
                      ))
                ],
              ),
              sizeFieldMinPlaceHolder,
              CustomTextField(
                headText: AppStrings.age,
                borderEnable: true,
                text: AppStrings.age,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: controller.setAgeNumber,
                fontWeight: FontWeight.normal,
              ),
              sizeFieldMinPlaceHolder,
              CustomTextField(
                controller: groupAgeTextController,
                suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
                headText: AppStrings.ageGroup,
                borderEnable: true,
                text: AppStrings.ageGroup,
                validator: EmptyFieldValidator.validator,
                fontWeight: FontWeight.normal,
                readOnly: true,
                onTap: () {
                  showRadioOptionDialog(
                      context,
                      AppStrings.selectAgeGroup,
                      ConfigService().getAgeGroups(),
                      controller.selectedAgeGroup,
                      (onChanged) => controller.selectedAgeGroup,
                      (onConfirmed) {
                    controller.setAgeGroup(onConfirmed!);
                    controller.update();
                    groupAgeTextController.text =
                        controller.selectedAgeGroup?.name ?? "";
                  }, (itemToString) => itemToString?.name ?? "");
                },
              ),
              sizeFieldMinPlaceHolder,
              CustomTextField(
                controller: deathTypeTextController,
                suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
                headText: AppStrings.deathType,
                borderEnable: true,
                text: AppStrings.deathType,
                validator: EmptyFieldValidator.validator,
                fontWeight: FontWeight.normal,
                readOnly: true,
                onTap: () async {
                  showRadioOptionDialog(
                      context,
                      AppStrings.selectType,
                      ConfigService().getDeathTypes(),
                      controller.selectedDeathType,
                          (onChanged) => controller.selectedDeathType,
                          (onConfirmed) {
                        controller.setDeathType(onConfirmed!);
                        controller.update();
                        deathTypeTextController.text =
                            controller.selectedDeathType?.name ?? "";
                      }, (itemToString) => itemToString?.name ?? "");

                },
              ),
              sizeFieldLargePlaceHolder,
              ButtonWidget(
                isLoading: controller.isApiResponseLoaded,
                text: AppStrings.submit,
                buttonType: ButtonType.gradient,
                textStyle:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                onPressed: () {
                  if (puDeathReportFormKey.currentState!.validate()) {
                    if (selectedGender == null) {
                      showSnackBar(context, AppStrings.selectGender);
                    } else {
                      controller.postDeathReportFormToServer(
                        widget.deathFormCode,
                          widget.deathBodyBandCode,
                          selectedGender!,UserRole.emergency,widget.policeStationsList);
                    }
                  }
                },
              ),
              sizeFieldMediumPlaceHolder,
            ]),
      );
    });
  }
}
