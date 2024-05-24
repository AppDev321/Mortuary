import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mortuary/core/constants/api_messages.dart';
import 'package:mortuary/core/constants/app_strings.dart';
import 'package:mortuary/core/enums/enums.dart';
import 'package:mortuary/features/authentication/builder_ids.dart';
import 'package:mortuary/features/authentication/domain/enities/session.dart';
import 'package:mortuary/features/authentication/domain/enities/user_model.dart';
import 'package:mortuary/features/authentication/presentation/pages/login_screen.dart';
import 'package:mortuary/features/authentication/presentation/pages/otp_verification_screen.dart';
import 'package:mortuary/features/authentication/presentation/pages/reset_password_screen.dart';
import 'package:mortuary/features/death_report/presentation/widget/report_death_screen.dart';

import '../../../../../core/error/errors.dart';
import '../../../../../core/popups/show_popups.dart';
import '../../../../core/utils/common_api_data.dart';
import '../../../../core/utils/utils.dart';
import '../../data/repositories/death_report_repo.dart';

class DeathReportController extends GetxController {
  final DeathReportRepo deathReportRepo;
  DeathReportController({required this.deathReportRepo});

  CustomError? customError;
  int deathNumberCount = 1;
  void setNumberOfDeathReport(int deathCount) => deathNumberCount = deathCount ;

  RadioOption? selectedGeneralLocation;
  void setGeneralLocation(RadioOption loc) => selectedGeneralLocation = loc ;


  UserRole? currentUserRole;
  setUserRole(UserRole role) {
    currentUserRole = role;
  }

  var apiResponseLoaded = LoadingState.loading;
  bool get isApiResponseLoaded =>
      apiResponseLoaded == LoadingState.loading;


  onErrorShowDialog(error) {
    onApiResponseCompleted();
    getErrorDialog(error);
  }

  onApiResponseCompleted() {
    apiResponseLoaded = LoadingState.loaded;
    onUpdateUI();
  }

  onApiRequestStarted() {
    apiResponseLoaded = LoadingState.loading;
    onUpdateUI();
  }

  onUpdateUI() {
    update([updatedAuthWrapper, updateEmailScreen, updateOTPScreen]);
  }
}
