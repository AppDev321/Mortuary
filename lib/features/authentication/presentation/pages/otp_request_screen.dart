import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/place_holders.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/button_widget.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/custom_text_widget.dart';
import '../../builder_ids.dart';
import '../get/auth_controller.dart';

class OTPRequestScreen extends StatelessWidget {
  OTPRequestScreen({super.key});

  final otpRequestFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AuthController>(
          id: updateOTPScreen,
          builder: (authController) {
            return Container(
              padding: const EdgeInsets.all(30),
              width: double.maxFinite,
              height: double.maxFinite,
              decoration: BoxDecoration(gradient: AppColors.appBackgroundColor),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: otpRequestFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomTextWidget(
                          text: AppStrings.verification.toUpperCase(),
                          colorText: AppColors.themeTextColor,
                          size: 24,
                          fontWeight: FontWeight.w800,
                        ),
                        sizeFieldLargePlaceHolder,
                        const CustomTextWidget(
                          textAlign: TextAlign.center,
                          text: AppStrings.verificationLabelMsg,
                          size: 13,
                          colorText: AppColors.secondaryTextColor,
                        ),
                        sizeFieldLargePlaceHolder,
                        CustomTextField(
                          prefixIcon: const Icon(Icons.email),
                          headText: AppStrings.email,
                          borderEnable: true,
                          text: AppStrings.email,
                          //validator: EmailValidator.validator,
                          fontWeight: FontWeight.normal,
                          onChanged: authController.setEmail,
                        ),
                        sizeFieldMediumPlaceHolder,
                        CustomTextField(
                          prefixIcon: const Icon(Icons.phone_android),
                          headText: AppStrings.phoneNumber,
                          borderEnable: true,
                          text: AppStrings.phoneNumber,
                          validator: PhoneValidator.validator,
                          fontWeight: FontWeight.normal,
                          onChanged: authController.setPhone,
                          // inputFormatters: [ FilteringTextInputFormatter.digitsOnly,],
                        ),
                        sizeFieldLargePlaceHolder,
                        ButtonWidget(
                          isLoading: authController.isAuthenticating,
                          text: AppStrings.requestCode,
                          buttonType: ButtonType.gradient,
                          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                          onPressed: () {
                            if (otpRequestFormKey.currentState!.validate()) {
                              authController.forgotPassword(context);
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
