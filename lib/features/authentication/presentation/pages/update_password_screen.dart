import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mortuary/core/constants/app_strings.dart';
import 'package:mortuary/core/constants/place_holders.dart';
import 'package:mortuary/core/widgets/custom_text_widget.dart';
import 'package:mortuary/features/authentication/presentation/pages/otp_request_screen.dart';

import '../../../../core/styles/colors.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/button_widget.dart';
import '../../../../core/widgets/custom_password_field.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../builder_ids.dart';
import '../get/auth_controller.dart';

class UpdatePasswordScreen extends StatelessWidget {
  UpdatePasswordScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: GetBuilder<AuthController>(
          id: updateSignupScreen,
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
                        text: AppStrings.updatePassword.toUpperCase(),
                        colorText: AppColors.themeTextColor,
                        size: 24,
                        fontWeight: FontWeight.w800,
                      ),
                      sizeFieldLargePlaceHolder,

                      CustomTextWidget(
                        textAlign: TextAlign.center,
                        text: AppStrings.updatePasswordScreenLabelMsg,
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
                        validator: PasswordValidator.validator,
                        onChanged: authController.setPassword,
                      ),

                      sizeFieldLargePlaceHolder,
                       ButtonWidget(
                        text: AppStrings.update,
                        buttonType: ButtonType.gradient,
                        textStyle:const  TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                        onPressed:(){ Go.to(()=> OTPRequestScreen());},
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
