import 'package:flutter/cupertino.dart';
import 'package:mortuary/core/constants/app_strings.dart';

import '../styles/icons.dart';

class CustomError {
  IconData iconData;
  String title;
  dynamic message;
  String stackTrace;

  CustomError(
      {required this.iconData,
      required this.title,
      required this.message,
      required this.stackTrace});
}

class GeneralError extends CustomError {
  GeneralError(
      {super.iconData = AppIcons.iconError,
      super.title = AppStrings.defaultGeneralErrorTitle,
      super.message = AppStrings.defaultGeneralErrorMessage,
      super.stackTrace = AppStrings.emptyString});
}

///This error is thrown when user enters in application and
///if client id is expired,disabled by admin,or have'nt paid,
class ClientError extends CustomError {
  ClientError(
      {super.iconData = AppIcons.iconServerError,
      super.title = AppStrings.defaultClientErrorTitle,
      super.message = AppStrings.defaultClientErrorMessage,
      super.stackTrace = AppStrings.emptyString});
}

class NetworkError extends CustomError {
  NetworkError(
      {super.iconData = AppIcons.iconNoInternet,
      super.title = AppStrings.defaultNetworkErrorTitle,
      super.message = AppStrings.defaultNetworkErrorMessage,
      super.stackTrace = AppStrings.emptyString});
}
