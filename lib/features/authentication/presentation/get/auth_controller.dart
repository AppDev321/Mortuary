import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mortuary/core/constants/api_messages.dart';
import 'package:mortuary/core/constants/app_strings.dart';
import 'package:mortuary/core/enums/enums.dart';
import 'package:mortuary/core/services/fcm_controller.dart';
import 'package:mortuary/features/authentication/builder_ids.dart';
import 'package:mortuary/features/authentication/domain/enities/session.dart';
import 'package:mortuary/features/authentication/presentation/pages/login_screen.dart';
import 'package:mortuary/features/authentication/presentation/pages/otp_verification_screen.dart';
import 'package:mortuary/features/authentication/presentation/pages/reset_password_screen.dart';
import 'package:mortuary/features/death_report/presentation/widget/common/death_report_list_screen.dart';
import 'package:mortuary/features/death_report/presentation/widget/authorized_person/report_death_screen.dart';
import 'package:mortuary/features/processing_unit_report/presentation/widget/morgue/morgue_home_screen.dart';

import '../../../../../core/error/errors.dart';
import '../../../../../core/popups/show_popups.dart';
import '../../../../core/utils/utils.dart';
import '../../../../main.dart';
import '../../../processing_unit_report/presentation/widget/processing_unit/home_screen.dart';
import '../../data/repositories/auth_repo.dart';

class AuthController extends GetxController {
  final AuthenticationRepo authUseRepo;

  AuthController({required this.authUseRepo});

  final fcmController = Get.find<FCMController>();

//  Rxn<User> userData = Rxn<User>();
  String email = '';
  String password = '';

  String forgotPasswordEmail = '';
  String confirmPassword = '';
  String phone = '';
  String phonePassword = '';
  int otpCode = 0;

  int? userId;
  bool isLoggedIn = false;
  bool isLoggedInAsGuest = false;
  Session? session;

  UserRole? get currentUserRole => session?.userRoleType;

  var phoneAuthenticationState = LoadingState.loading;
  var verifyUserState = LoadingState.loaded;
  var authenticationState = LoadingState.loaded;
  var resetPwdAuthenticationState = LoadingState.loaded;

  bool get isPhoneAuthenticating =>
      phoneAuthenticationState == LoadingState.loading;

  bool get isVerifyingUser => verifyUserState == LoadingState.loading;

  bool get isAuthenticating => authenticationState == LoadingState.loading;

  bool get isResetPwdAuthenticating =>
      resetPwdAuthenticationState == LoadingState.loading;

  void setEmail(String? newEmail) => email = newEmail ?? '';

  void setForgotPasswordEmail(String? newEmail) =>
      forgotPasswordEmail = newEmail ?? '';

  void setPhone(String? newPhone) => phone = newPhone ?? '';

  void setPassword(String? newPassword) => password = newPassword ?? '';

  void setConfirmed(String? newPassword) => confirmPassword = newPassword ?? '';

  void setPhonePassword(String? newPassword) =>
      phonePassword = newPassword ?? '';

  login(BuildContext context) async {
    onApiRequestStarted();
    await authUseRepo
        .login(
            emailAddress: email,
            password: password,
            deviceFcmToken: fcmController.fcmToken.value)
        .then((value) async {
      session = value;
      onApiResponseCompleted();
      isUserLoggedIn = true;
      if (currentUserRole == UserRole.volunteer) {
        Get.offAll(() => ReportDeathScreen(currentUserRole: currentUserRole!));
      } else if (currentUserRole == UserRole.transport) {
        Get.offAll(() => DeathReportListScreen(userRole: currentUserRole!));
      } else if (currentUserRole == UserRole.emergency) {
        Get.offAll(() => PUHomeScreen(currentUserRole: currentUserRole!));
      } else if (currentUserRole == UserRole.morgue) {
        Get.offAll(() => MorgueHomeScreen(currentUserRole: currentUserRole!));
      } else {
        showSnackBar(context, ApiMessages.unIdentifiedRole);
      }
    }).onError<CustomError>((error, stackTrace) async {
      onErrorShowDialog(error);
    });
  }

  forgotPassword(BuildContext context) async {
    onApiRequestStarted();

    await authUseRepo
        .forgotPassword(emailAddress: email, phoneNumber: phone)
        .then((value) async {
      onApiResponseCompleted();

      var alertData = GeneralError(
        message: '${value.data}',
        title: value.message,
      );
      Go.off(() => const OTPVerificationScreen());
      // showAppThemedDialog(alertData,
      //     showErrorMessage: false, dissmisableDialog: false, onPressed: () {
      //   Get.back();
      //   Go.off(() => const OTPVerificationScreen());
      // });
    }).onError<CustomError>((error, stackTrace) async {
      onErrorShowDialog(error);
    });
  }

  verifyOTP(BuildContext context) async {
    onApiRequestStarted();
    await authUseRepo
        .verifyOTP(emailAddress: email, phoneNumber: phone, otpCode: otpCode)
        .then((value) async {
      onApiResponseCompleted();
      Get.back();
      Go.to(() => ResetPasswordScreen());
    }).onError<CustomError>((error, stackTrace) async {
      onErrorShowDialog(error);
    });
  }

  resetPassword(BuildContext context) async {
    onApiRequestStarted();
    await authUseRepo
        .resetPassword(
            emailAddress: email,
            phoneNumber: phone,
            confirmPassword: confirmPassword,
            password: password)
        .then((value) async {
      onApiResponseCompleted();
      var alertData = GeneralError(
        message: value.message,
        title: AppStrings.resetPassword,
      );
      showAppThemedDialog(alertData,
          showErrorMessage: false, dissmisableDialog: false, onPressed: () {
        Get.offAll(() => LoginScreen());
      });
    }).onError<CustomError>((error, stackTrace) async {
      print(error.title);
      onErrorShowDialog(error);
    });
  }

  onErrorShowDialog(error) {
    onApiResponseCompleted();
    showAppThemedDialog(error);
  }

  onApiResponseCompleted() {
    authenticationState = LoadingState.loaded;
    onUpdateUI();
  }

  onApiRequestStarted() {
    authenticationState = LoadingState.loading;
    onUpdateUI();
  }

  onUpdateUI() {
    update([updatedAuthWrapper, updateEmailScreen, updateOTPScreen]);
  }
}
