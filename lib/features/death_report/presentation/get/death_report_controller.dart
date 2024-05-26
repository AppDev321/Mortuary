import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:mortuary/core/constants/api_messages.dart';
import 'package:mortuary/core/enums/enums.dart';
import 'package:mortuary/core/services/notification_service.dart';
import 'package:mortuary/core/services/push_notification_sevice.dart';
import 'package:mortuary/features/authentication/presentation/component/gender_option_widget.dart';
import 'package:mortuary/features/death_report/domain/enities/death_report_form_params.dart';
import 'package:mortuary/features/death_report/domain/enities/death_report_list_reponse.dart';
import 'package:mortuary/features/death_report/presentation/widget/report_death_screen.dart';
import '../../../../../core/error/errors.dart';
import '../../../../../core/popups/show_popups.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/utils.dart';
import '../../../google_map/get/google_map_controller.dart';
import '../../../qr_scanner/presentation/widget/ai_barcode_scanner.dart';
import '../../../splash/domain/entities/splash_model.dart';
import '../../builder_ids.dart';
import '../../data/repositories/death_report_repo.dart';
import '../../domain/enities/death_report_alert.dart';
import '../widget/death_report_form.dart';
import '../widget/pickup_map_view.dart';

class DeathReportController extends GetxController {
  final DeathReportRepo deathReportRepo;
  final GoogleMapScreenController googleMapScreenController;

  DeathReportController(
      {required this.deathReportRepo, required this.googleMapScreenController});

  int deathNumberCount = 1;

  void setNumberOfDeathReport(int deathCount) => deathNumberCount = deathCount;

  UserRole? currentUserRole;

  setUserRole(UserRole role) {
    currentUserRole = role;
  }

  var apiResponseLoaded = LoadingState.loaded;

  bool get isApiResponseLoaded => apiResponseLoaded == LoadingState.loading;

  bool isScanCodeCompleted = false;
  String qrScannedValue = "";

  RadioOption? selectedGeneralLocation;

  void setGeneralLocation(RadioOption loc) => selectedGeneralLocation = loc;
  RadioOption? selectedAgeGroup;

  void setAgeGroup(RadioOption ageGroup) => selectedAgeGroup = ageGroup;
  RadioOption? selectedVisaType;

  void setVisaType(RadioOption visaType) => selectedVisaType = visaType;

  int ageNumber = 0;
  void setAgeNumber(String age) =>
      ageNumber = int.parse(age.isEmpty ? "0" : age);

  String idNumber = "";
  void setIdNumber(String number) => idNumber = number;

  int deathReportIDFromApi = 0;
  List<DeathReportListResponse> deathReportList = [];



  initiateVolunteerDeathReport(BuildContext context) async {
    onApiRequestStarted();
    googleMapScreenController.getUserCurrentPosition().then((value) async {
      print("Current Location ==> ${value.formattedAddress}");

      if (value.geometry == null) {
        var loc = await googleMapScreenController.getPositionPoints();
        initiateDeathReportToServer(
            loc.latitude, loc.longitude, value.formattedAddress ?? "");
      } else {
        initiateDeathReportToServer(value.geometry!.location.lat,
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

  sendPositionCoordinates() async {
    onApiRequestStarted();
    googleMapScreenController.getPositionPoints().then((value) async {
      List<Placemark> placeMarksList =
          await placemarkFromCoordinates(value.latitude, value.longitude);

      Placemark place = placeMarksList[0];
      var currentAddress =
          "${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}";

      print("Force Location ==> ${currentAddress}");

      initiateDeathReportToServer(value.latitude, value.longitude, currentAddress);
    }).onError((error, stackTrace) {
      print(error);
      onErrorShowDialog(error);
    });
  }

  initiateDeathReportToServer(double lat, double lng, String currentAddress) {
    deathReportRepo
        .volunteerDeathReport(
            deathBodyCount: deathNumberCount,
            locationId: selectedGeneralLocation?.id ?? 0,
            lat: lat,
            lng: lng,
            address: currentAddress)
        .then((response) async {
      onApiResponseCompleted();

      var locationShareAlert =
          GeneralError(title: "", message: response.message);
      showAppThemedDialog(locationShareAlert,
          dissmisableDialog: false, showErrorMessage: false, onPressed: () {

            deathReportIDFromApi = response.deathReportId;

            showQRCodeScannerScreen();
          });


    }).onError<CustomError>((error, stackTrace) async {
      onErrorShowDialog(error);
    });
  }

  showQRCodeScannerScreen() {
    Go.to(() => AiBarcodeScanner(
          canPop: false,
          onScan: (String value) {
            if (isScanCodeCompleted == false) {
              isScanCodeCompleted = true;
              qrScannedValue = value;
            }
          },
        ));
  }

  postQRCodeToServer(String qrCode) {
    onApiRequestStarted();
    deathReportRepo.postQRScanCode(qrCode).then((value) {
      isScanCodeCompleted = false;
      qrScannedValue = "";
      onApiResponseCompleted();
     Go.off(() => DeathReportFormScreen(
                 deathBodyBandCode: value, deathFormCode: deathReportIDFromApi));


    }).onError<CustomError>((error, stackTrace) async {
      isScanCodeCompleted = false;
      qrScannedValue = "";
      onErrorShowDialog(error);
    });


  }

  postDeathReportFormToServer(
      int deathReportId, int bandCodeId, Gender gender) {
    var request = DeathReportFormRequest(
        deathReportId: deathReportId,
        visaTypeId: selectedVisaType?.id ?? 0,
        bandCodeId: bandCodeId,
        idNumber: idNumber,
        genderId: gender.id,
        age: ageNumber,
        ageGroupId: selectedAgeGroup?.id ?? 0);

    onApiRequestStarted();
    deathReportRepo.postDeathReportForm(formRequest: request).then((response) {
      onApiResponseCompleted();
      deathNumberCount--;
      var customError = GeneralError(
        title: response['title'],
        message: response['message'],
      );

      showAppThemedDialog(customError,
          showErrorMessage: false, dissmisableDialog: false, onPressed: () {
        int remainingDeathCount = response['remainingCount'];
        if (remainingDeathCount > 0) {
          Get.back();
          showQRCodeScannerScreen();
        }
      });
    }).onError<CustomError>((error, stackTrace) async {
      onApiResponseCompleted();
      if (deathNumberCount == 1) {
        var customError = GeneralError(
          title: "",
          message: AppStrings.allDeathReportsPosted,
        );
        Get.offAll(() => ReportDeathScreen(currentUserRole: currentUserRole!));
        showAppThemedDialog(customError,
            showErrorMessage: false, dissmisableDialog: false, onPressed: () {

        });
      } else {
        onErrorShowDialog(error);
      }
    });
  }



  Future<List<DeathReportListResponse>> getDeathReportList(UserRole userRole) async {
    deathReportList.clear();
    onApiRequestStarted();
   await deathReportRepo.getDeathReportList(userRole).then((response) {
     deathReportList = response;
      onApiResponseCompleted();
    }).onError<CustomError>((error, stackTrace) async {
      print(error.message);
        onErrorShowDialog(error);
    });
    return deathReportList;
  }

  Future<List<DeathReportAlert>> checkAnyAlerts() async {
    List<DeathReportAlert> alertList = [];
    onApiRequestStarted();
    await deathReportRepo.checkAnyAlertExits().then((response) {
      alertList = response;
      onApiResponseCompleted();
      if(alertList.isNotEmpty) {
        var pickFirstNotificationAlert = alertList.first;
        NotificationService().newNotification("Death Alert at ${pickFirstNotificationAlert.address}", "", true);
      }
    }).onError<CustomError>((error, stackTrace) async {
      onErrorShowDialog(error);
    });
    return alertList;
  }


  getDeathReportById(DeathReportAlert deathReportAlert) async {
    // onApiRequestStarted();
    // await deathReportRepo.getDeathReportDetailsById(deathReportId: deathReportId).then((response) {
    //   onApiResponseCompleted();
    //
    //
    // }).onError<CustomError>((error, stackTrace) async {
    //   onErrorShowDialog(error);
    // });

  }



  acceptDeathReportByTransport(DeathReportAlert deathReportAlert) async {
    onApiRequestStarted();
    await deathReportRepo.acceptDeathReportAlertByTransport(
        deathReportId: deathReportAlert.deathReportId)
        .then((response) {
      onApiResponseCompleted();
      var dialogData = GeneralError(
        title: response['title'],
        message: response['message']
      );
      showAppThemedDialog(dialogData,showErrorMessage: false,dissmisableDialog: false,onPressed: (){
        print(response['data']);
    Go.off(()=>PickupMapScreen(dataModel: DeathReportAlert.fromJson(response['data'])));
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
    update([updateDeathReportScreen]);
    //update([updatedAuthWrapper, updateEmailScreen, updateOTPScreen]);
  }
}
