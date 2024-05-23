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
import '../../data/repositories/auth_repo.dart';

class AuthController extends GetxController {
  final AuthenticationRepo authUseRepo;
  AuthController({required this.authUseRepo});

  CustomError? customError;
  Rxn<User> userData = Rxn<User>();
  String? email = '';
  String? forgotPasswordEmail = '';
  String? password = '';
  String? phone;
  String? phonePassword = '';
  int? userId;
  bool isLoggedIn = false;
  bool isLoggedInAsGuest = false;
  Session? session;



  var phoneAuthenticationState = LoadingState.loading;
  var verifyUserState = LoadingState.loaded;
  var authenticationState = LoadingState.loaded;
  var resetPwdAuthenticationState = LoadingState.loaded;

  bool get isPhoneAuthenticating => phoneAuthenticationState == LoadingState.loading;
  bool get isVerifyingUser => verifyUserState == LoadingState.loading;
  bool get isAuthenticating => authenticationState == LoadingState.loading;
  bool get isResetPwdAuthenticating => resetPwdAuthenticationState == LoadingState.loading;



  void setEmail(String? newEmail) => email = newEmail;
  void setForgotPasswordEmail(String? newEmail) => forgotPasswordEmail = newEmail;
  void setPhone(String? newPhone) => phone = newPhone;
  void setPassword(String? newPassword) => password = newPassword;
  void setPhonePassword(String? newPassword) => phonePassword = newPassword;



  login(BuildContext context) async {
    onApiRequestStarted();
    await authUseRepo
        .login(emailAddress: email!, password: password!)
        .then((value) async {
      session = value;
      onApiResponseCompleted();
    }).onError<CustomError>((error, stackTrace) async {
      onErrorShowDialog(error);
    });
  }



  onErrorShowDialog(error)
  {
    onApiResponseCompleted();
    getErrorDialog(error);
  }
  onApiResponseCompleted()
  {
    authenticationState = LoadingState.loaded;
    onUpdateUI();
  }
  onApiRequestStarted()
  {
    authenticationState = LoadingState.loading;
    onUpdateUI();
  }
  onUpdateUI(){
    update([updatedAuthWrapper, updateEmailScreen]);
  }


}
