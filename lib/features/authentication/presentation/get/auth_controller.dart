import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mortuary/core/enums/enums.dart';
import 'package:mortuary/core/services/file_service.dart';
import 'package:mortuary/features/authentication/builder_ids.dart';
import 'package:mortuary/features/authentication/domain/enities/session.dart';
import 'package:mortuary/features/authentication/domain/enities/user_model.dart';

import '../../../../../core/error/errors.dart';
import '../../../../../core/popups/show_popups.dart';
import '../../../../../core/popups/show_snackbar.dart';
import '../../../../init_main.dart';
import '../../data/repositories/auth_repo_impl.dart';

class AuthController extends GetxController {
  CustomError? customError;
  final AuthenticationRepo authUseRepo;

  AuthController({required this.authUseRepo});

  final loginFormKey = GlobalKey<FormState>();

  Rxn<User> userData = Rxn<User>();

  String? email = '';
  String? forgotPasswordEmail = '';
  String? password = '';
  String? phone;
  String? phonePassword = '';

  int? userId;

  setEmail(String? newEmail) {
    email = newEmail;
  }

  setForgotPasswordEmail(String? newEmail) {
    forgotPasswordEmail = newEmail;
  }

  setPhone(String? newPhone) {
    phone = newPhone;
  }

  setPassword(String? newPassword) {
    password = newPassword;
  }

  setPhonePassword(String? newPassword) {
    phonePassword = newPassword;
  }

  LoadingState phoneAuthenticationState = LoadingState.loading;

  LoadingState verifyUserState = LoadingState.loaded;

  bool get isPhoneAuthenticating =>
      phoneAuthenticationState == LoadingState.loading;

  bool get isVerifyingUser => verifyUserState == LoadingState.loading;

  LoadingState authenticationState = LoadingState.loading;

  bool get isAuthenticating => authenticationState == LoadingState.loading;

  LoadingState resetPwdAuthenticationState = LoadingState.loaded;

  bool get isResetPwdAuthenticating =>
      resetPwdAuthenticationState == LoadingState.loading;
  bool isLoggedIn = false;
  bool isLoggedInAsGuest = false;

  Session? session;

  login(BuildContext context) async {
    if (!loginFormKey.currentState!.validate()) {
      return;
    }
    authenticationState = LoadingState.loading;
    update([updatedAuthWrapper, updateEmailScreen]);
    await authUseRepo
        .login(emailAddress: email!, password: password!)
        .then((value) async {
      session = value;
      authenticationState = LoadingState.loaded;
      update([updatedAuthWrapper, updateEmailScreen]);
    }).onError<CustomError>((error, stackTrace) async {
      print('error is ${error.message}');
      authenticationState = LoadingState.loaded;
      update([updatedAuthWrapper, updateEmailScreen]);
      getErrorDialog(error);
    });
  }

}
