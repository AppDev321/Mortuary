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

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AuthController>(
          id: updatedAuthWrapper,
          builder: (authController) {
            return Container(
              padding: const EdgeInsets.all(30),
              width: double.maxFinite,
              height: double.maxFinite,
              decoration: BoxDecoration(gradient: AppColors.appBackgroundColor),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: loginFormKey,
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
                          prefixIcon: const Icon(Icons.email),
                          headText: AppStrings.email,
                          borderEnable: true,
                          text: AppStrings.email,
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
                        InkWell(
                          onTap: ()=>Go.to(()=>OTPRequestScreen()),
                          child: const Align(
                            alignment: Alignment.centerRight,
                            child: CustomTextWidget(

                              textDecoration: TextDecoration.underline,
                              textAlign: TextAlign.end,
                              text: "${AppStrings.forgotPassword}?",
                            ),
                          ),
                        ),
                        sizeFieldLargePlaceHolder,
                        ButtonWidget(
                          text: AppStrings.login,
                          buttonType: ButtonType.gradient,
                          isLoading: authController.isAuthenticating,
                          textStyle: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                          onPressed: () {
                            if (loginFormKey.currentState!.validate()) {
                              authController.login(context);
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
