import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mortuary/core/constants/app_assets.dart';
import 'package:mortuary/core/constants/place_holders.dart';
import 'package:mortuary/core/styles/colors.dart';
import 'package:mortuary/core/utils/widget_extensions.dart';
import 'package:mortuary/core/widgets/custom_screen_widget.dart';
import 'package:mortuary/core/widgets/custom_text_widget.dart';
import 'package:mortuary/features/authentication/presentation/component/gender_option_widget.dart';
import 'package:mortuary/features/death_report/presentation/components/report_list_component.dart';
import 'package:mortuary/features/splash/presentation/get/splash_controller.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/animated_widget.dart';
import '../../../../core/widgets/button_widget.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/load_more_listview.dart';

class DeathReportFormScreen extends StatefulWidget {
  DeathReportFormScreen({Key? key}) : super(key: key);

  @override
  State<DeathReportFormScreen> createState() => _DeathReportFormScreenState();
}

class _DeathReportFormScreenState extends State<DeathReportFormScreen> {
  List<Gender> genders = [];

  @override
  void initState() {
    super.initState();
    genders.add(Gender("Male", AppAssets.icMale, false));
    genders.add(Gender("Female", AppAssets.icFemale, false));
  }

  @override
  Widget build(BuildContext context) {
    return CustomScreenWidget(
        titleText: AppStrings.reportDeath.toUpperCase(),
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomTextWidget(
            text: AppStrings.reportFormDesc,
            size: 13,
            colorText: AppColors.secondaryTextColor,
            textAlign: TextAlign.center,
          ),
          sizeFieldLargePlaceHolder,
          CustomTextField(
            suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
            headText: AppStrings.idType,
            borderEnable: true,
            text: AppStrings.idType,
            // validator: EmailValidator.validator,
            fontWeight: FontWeight.normal,
            readOnly: true,
          ),
          sizeFieldMinPlaceHolder,
          CustomTextField(
            headText: AppStrings.idNumber,
            borderEnable: true,
            text: AppStrings.idNumber,
            // validator: EmailValidator.validator,
            fontWeight: FontWeight.normal,
          ),
          sizeFieldMinPlaceHolder,
          Align(
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
                        genders.forEach((gender) => gender.isSelected = false);
                        e.isSelected = true;
                      });
                    },
                    child: CustomGenderRadio(e),
                  ))
            ],
          ),
          sizeFieldMinPlaceHolder,
          CustomTextField(
            suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
            headText: AppStrings.ageGroup,
            borderEnable: true,
            text: AppStrings.ageGroup,
            // validator: EmailValidator.validator,
            fontWeight: FontWeight.normal,
            readOnly: true,
          ),

          sizeFieldLargePlaceHolder,
          sizeFieldMediumPlaceHolder,
          ButtonWidget(
            text: AppStrings.submit,
            buttonType: ButtonType.gradient,

            textStyle:const  TextStyle(
                fontSize: 15, fontWeight: FontWeight.w600),
            onPressed:(){ },
          ),

          sizeFieldMediumPlaceHolder,
          CustomTextWidget(
            text: AppStrings.skipForm,
            size: 13,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.bold,
          ),
        ]);
  }


}
