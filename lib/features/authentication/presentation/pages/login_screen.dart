import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mortuary/core/constants/app_strings.dart';
import 'package:mortuary/core/constants/place_holders.dart';
import 'package:mortuary/core/widgets/custom_text_widget.dart';
import 'package:mortuary/features/authentication/presentation/pages/otp_request_screen.dart';

import '../../../../core/styles/colors.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/button_widget.dart';
import '../../../../core/widgets/custom_password_field.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../builder_ids.dart';
import '../get/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});


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
                        text: AppStrings.login.toUpperCase(),
                        colorText: AppColors.themeTextColor,
                        size: 24,
                        fontWeight: FontWeight.w800,
                      ),
                      sizeFieldLargePlaceHolder,
                      CustomTextField(
                        prefixIcon: const Icon(Icons.person),
                        headText: AppStrings.username,
                        borderEnable: true,
                        text: AppStrings.username,
                        // label: 'Email',
                        validator: EmailValidator.validator,
                        fontWeight: FontWeight.normal,
                        onChanged: authController.setEmail,
                      ),
                      sizeFieldMediumPlaceHolder,
                      PasswordField(
                        prefixIcon: const Icon(Icons.key),
                        borderEnable: true,
                        labelText: AppStrings.password,
                        validator: PasswordValidator.validator,
                        onChanged: authController.setPassword,
                      ),
                      sizeFieldMediumPlaceHolder,
                      const Align(
                        alignment: Alignment.centerRight,
                        child: CustomTextWidget(
                          textDecoration: TextDecoration.underline,
                          textAlign: TextAlign.end,
                          text: "${AppStrings.forgotPassword}?",
                        ),
                      ),
                      sizeFieldLargePlaceHolder,
                       ButtonWidget(
                        text: AppStrings.login,
                        buttonType: ButtonType.gradient,

                        textStyle:const  TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                        onPressed:(){ Get.to(()=> OTPRequestScreen());},
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
