import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mortuary/core/constants/app_assets.dart';
import 'package:mortuary/core/popups/show_popups.dart';
import 'package:mortuary/core/utils/common_api_data.dart';
import 'package:mortuary/core/widgets/button_widget.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/place_holders.dart';
import '../../../../core/enums/enums.dart';
import '../../../../core/widgets/radio_option_dialog_view.dart';
import '../../../../core/widgets/custom_screen_widget.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/custom_text_widget.dart';

class DeathCountScreen extends StatelessWidget {
  final UserRole currentUserRole;

  DeathCountScreen({Key? key, required this.currentUserRole}) : super(key: key);
  RadioOption? visaType;

  @override
  Widget build(BuildContext context) {
    return CustomScreenWidget(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomTextWidget(
            text: AppStrings.numberOfDeaths.toUpperCase(),
            size: 24,
            fontWeight: FontWeight.w700,
          ),
          sizeFieldLargePlaceHolder,
          sizeFieldLargePlaceHolder,
          sizeFieldLargePlaceHolder,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ButtonWidget(
                expand: false,
                text: "-",
                buttonType: ButtonType.transparent,
                radius: 15,
                width: 60,
                textStyle:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              const CustomTextWidget(
                text: '0',
                size: 25,
                fontWeight: FontWeight.w700,
              ),
              ButtonWidget(
                expand: false,
                text: "+",
                buttonType: ButtonType.transparent,
                radius: 15,
                width: 60,
                textStyle:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ],
          ),
          sizeFieldLargePlaceHolder,
          sizeFieldLargePlaceHolder,
          const CustomTextField(
            suffixIcon: Icon(Icons.keyboard_arrow_down),
            headText: AppStrings.generalLocation,
            borderEnable: true,
            text: AppStrings.generalLocation,
            readOnly: true,
            fontWeight: FontWeight.normal,
          ),
          sizeFieldLargePlaceHolder,
          ButtonWidget(
            text: AppStrings.sharePinLocation,
            buttonType: ButtonType.gradient,
            icon: SvgPicture.asset(AppAssets.icPinLocation),
            textStyle:
                const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            onPressed: () {
              showRadioOptionDialog(context,
                  AppStrings.generalLocation,
                  getVisaTypeList(),
                  visaType,
                      (onChanged) => visaType, (onConfirmed) => visaType,(itemToString)=>itemToString?.name ?? "");
            },
          ),

        ]);
  }


}
