import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/place_holders.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/button_widget.dart';
import '../../../../core/widgets/custom_otp_fields.dart';
import '../../../../core/widgets/custom_text_widget.dart';
import '../../builder_ids.dart';
import '../get/auth_controller.dart';

class OTPVerificationScreen extends StatelessWidget {
  const OTPVerificationScreen({super.key});

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
                        text: AppStrings.verificationScreenLabelMsg,
                        size: 13,
                        colorText: AppColors.secondaryTextColor,
                      ),
                      sizeFieldLargePlaceHolder,
                      CustomOtpFields(

                        onCompleted: (value) {
                        authController.otpCode = int.parse(value);
                      }, onChanged: (value) {
                        authController.otpCode = 0;
                      },),

                      sizeFieldLargePlaceHolder,
                       ButtonWidget(
                        text: AppStrings.verify,
                        buttonType: ButtonType.gradient,
                        isLoading: authController.isAuthenticating,
                        textStyle: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                        onPressed: (){
                            if (authController.otpCode == 0) {
                              showSnackBar(context, AppStrings.otpError);
                            } else {
                              authController.verifyOTP(context);
                            }
                          }

                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
