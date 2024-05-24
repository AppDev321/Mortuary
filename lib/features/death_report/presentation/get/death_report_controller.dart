import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mortuary/core/enums/enums.dart';
import 'package:mortuary/features/authentication/builder_ids.dart';
import '../../../../../core/error/errors.dart';
import '../../../../../core/popups/show_popups.dart';
import '../../../../core/utils/utils.dart';
import '../../../splash/domain/entities/splash_model.dart';
import '../../data/repositories/death_report_repo.dart';
import 'package:geolocator/geolocator.dart';

class DeathReportController extends GetxController {
  final DeathReportRepo deathReportRepo;

  DeathReportController({required this.deathReportRepo});

  int deathNumberCount = 1;

  void setNumberOfDeathReport(int deathCount) => deathNumberCount = deathCount;

  RadioOption? selectedGeneralLocation;

  void setGeneralLocation(RadioOption loc) => selectedGeneralLocation = loc;

  UserRole? currentUserRole;

  setUserRole(UserRole role) {
    currentUserRole = role;
  }

  var apiResponseLoaded = LoadingState.loading;

  bool get isApiResponseLoaded => apiResponseLoaded == LoadingState.loading;




  initiateVolunteerDeathReport(BuildContext context) async {
    onApiRequestStarted();
    getUserCurrentPosition().then((value) async{
      await deathReportRepo
          .volunteerDeathReport(deathBodyCount:deathNumberCount,locationId: 1,latLng: value )
          .then((value) async {

            onApiResponseCompleted();

      }).onError<CustomError>((error, stackTrace) async {
        onErrorShowDialog(error);
      });

    }).onError((error, stackTrace) {
      var customError = GeneralError(message: error.toString());
      onErrorShowDialog(customError);
    });

  }







  onErrorShowDialog(error) {
    onApiResponseCompleted();
    showAppThemedDialog(error);
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
    update();
    //update([updatedAuthWrapper, updateEmailScreen, updateOTPScreen]);
  }
}
