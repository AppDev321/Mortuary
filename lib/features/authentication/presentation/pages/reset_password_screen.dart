import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mortuary/core/constants/app_strings.dart';
import 'package:mortuary/core/constants/place_holders.dart';
import 'package:mortuary/core/widgets/custom_text_widget.dart';

import '../../../../core/styles/colors.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/button_widget.dart';
import '../../../../core/widgets/custom_password_field.dart';
import '../../builder_ids.dart';
import '../get/auth_controller.dart';

class ResetPasswordScreen extends StatelessWidget {
   ResetPasswordScreen({super.key});
  final resetPasswordFormKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: GetBuilder<AuthController>(
          id: updateOTPScreen,
          builder: (authController) {
            return Form(
              key: resetPasswordFormKey,
              child: Container(
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
                          text: AppStrings.resetPassword.toUpperCase(),
                          colorText: AppColors.themeTextColor,
                          size: 24,
                          fontWeight: FontWeight.w800,
                        ),
                        sizeFieldLargePlaceHolder,
                        const CustomTextWidget(
                          textAlign: TextAlign.center,
                          text: AppStrings.resetPasswordScreenLabelMsg,
                          size: 13,
                          colorText: AppColors.secondaryTextColor,
                        ),
                        sizeFieldLargePlaceHolder,
                        PasswordField(
                          prefixIcon: const Icon(Icons.key),
                          borderEnable: true,
                          labelText: AppStrings.newPassword,
                          validator: PasswordValidator.validator,
                          onChanged: authController.setPassword,
                        ),
                        sizeFieldMediumPlaceHolder,
                        PasswordField(
                          prefixIcon: const Icon(Icons.key),
                          borderEnable: true,
                          labelText: AppStrings.retypePassword,
                          validator: (value) =>
                              ConfirmPasswordValidator.validator(
                                  value, authController.password),
                          onChanged: authController.setConfirmed,
                        ),
                        sizeFieldLargePlaceHolder,
                        ButtonWidget(
                          text: AppStrings.update,
                          buttonType: ButtonType.gradient,
                          isLoading: authController.isAuthenticating,
                          textStyle: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                          onPressed: () {
                            if(resetPasswordFormKey.currentState!.validate())
                              {
                                authController.resetPassword(context);
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
