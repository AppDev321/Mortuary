import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:mortuary/core/constants/api_messages.dart';
import 'package:mortuary/core/enums/enums.dart';
import '../../../../../core/error/errors.dart';
import '../../../../../core/popups/show_popups.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/utils.dart';
import '../../../google_map/get/google_map_controller.dart';
import '../../../qr_scanner/presentation/widget/ai_barcode_scanner.dart';
import '../../../splash/domain/entities/splash_model.dart';
import '../../data/repositories/death_report_repo.dart';
import '../widget/death_report_form.dart';

class DeathReportController extends GetxController {
  final DeathReportRepo deathReportRepo;
  final GoogleMapScreenController googleMapScreenController;

  DeathReportController(
      {required this.deathReportRepo, required this.googleMapScreenController});

  int deathNumberCount = 1;
  void setNumberOfDeathReport(int deathCount) => deathNumberCount = deathCount;

  RadioOption? selectedGeneralLocation;
  void setGeneralLocation(RadioOption loc) => selectedGeneralLocation = loc;

  UserRole? currentUserRole;
  setUserRole(UserRole role) {
    currentUserRole = role;
  }

  var apiResponseLoaded = LoadingState.loaded;
  bool get isApiResponseLoaded => apiResponseLoaded == LoadingState.loading;








  initiateVolunteerDeathReport(BuildContext context) async {
    onApiRequestStarted();
    googleMapScreenController.getUserCurrentPosition().then((value) async {
      print("Current Location ==> ${value.formattedAddress}");

      if (value.geometry == null) {
        var loc = await googleMapScreenController.getPositionPoints();
        initiateDeathReport(
            loc.latitude, loc.longitude, value.formattedAddress ?? "");
      } else {
        initiateDeathReport(value.geometry!.location.lat,
            value.geometry!.location.lng, value.formattedAddress ?? "");
      }

    }).onError((error, stackTrace) {
      onApiResponseCompleted();
      var customError = GeneralError(
        message: ApiMessages.locationAddressError,
      );
      showAppThemedDialog(customError,
          buttonText: AppStrings.shareOnlyLatLng,
          onPressed: () => sendPositionCoordinates());
    });
  }

  sendPositionCoordinates() async{
    onApiRequestStarted();
    googleMapScreenController.getPositionPoints().then((value) async {
      List<Placemark> placeMarksList =
          await placemarkFromCoordinates(value.latitude, value.longitude);

      Placemark place = placeMarksList[0];
      var currentAddress =
          "${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}";

      print("Force Location ==> ${currentAddress}");

      initiateDeathReport(value.latitude, value.longitude, currentAddress);
    }).onError((error, stackTrace) {
      print(error);
      onErrorShowDialog(error);
    });
  }

  initiateDeathReport(double lat, double lng, String currentAddress) {
    deathReportRepo
        .volunteerDeathReport(
            deathBodyCount: deathNumberCount,
            locationId: selectedGeneralLocation?.id ?? 0,
            lat: lat,
            lng: lng,
            address: currentAddress)
        .then((response) async {
      onApiResponseCompleted();

      var locationShareAlert = GeneralError(title: "", message: response.message);
      showAppThemedDialog(locationShareAlert, showErrorMessage: false,
          onPressed: () {
        Go.to(() => AiBarcodeScanner(
              canPop: false,
              onScan: (String value) {
                Go.off(() => DeathReportFormScreen(
                    deathBodyBandCode: value, deathFormCode: response.deathReportId));
              },
            ));
      });
    }).onError<CustomError>((error, stackTrace) async {
      onErrorShowDialog(error);
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
