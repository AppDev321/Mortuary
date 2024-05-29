import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:mortuary/core/constants/api_messages.dart';
import 'package:mortuary/core/enums/enums.dart';
import 'package:mortuary/core/services/notification_service.dart';
import 'package:mortuary/features/authentication/presentation/component/gender_option_widget.dart';
import 'package:mortuary/features/death_report/domain/enities/death_report_form_params.dart';
import 'package:mortuary/features/death_report/domain/enities/death_report_list_reponse.dart';
import 'package:mortuary/features/death_report/domain/enities/processing_center.dart';
import 'package:mortuary/features/death_report/presentation/widget/death_report_list_screen.dart';
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


  RadioOption? selectedGeneralLocation;
  void setGeneralLocation(RadioOption loc) => selectedGeneralLocation = loc;


  RadioOption? selectedAgeGroup;
  void setAgeGroup(RadioOption ageGroup) => selectedAgeGroup = ageGroup;

  RadioOption? selectedVisaType;
  void setVisaType(RadioOption visaType) => selectedVisaType = visaType;

  RadioOption? selectedDeathType;
  void setDeathType(RadioOption deathType) => selectedDeathType = deathType;

  RadioOption? selectedNationality;
  void setNationality(RadioOption nationality) => selectedNationality = nationality;

  int ageNumber = 0;
  void setAgeNumber(String age) =>
      ageNumber = int.parse(age.isEmpty ? "0" : age);

  String idNumber = "";
  void setIdNumber(String number) => idNumber = number;


  int transportScannedBodyCount = 1;



  List<DeathReportListResponse> deathReportList = [];



  /// ********  Volunteer Api Section Started ///////////


  initiateVolunteerDeathReport(BuildContext context,UserRole userRole) async {
    onApiRequestStarted();
    googleMapScreenController.getUserCurrentPosition().then((value) async {
      print("Current Location ==> ${value.formattedAddress}");

      if (value.geometry == null) {
        var loc = await googleMapScreenController.getPositionPoints();
        initiateDeathReportToServer(
            loc.latitude, loc.longitude, value.formattedAddress ?? "",userRole);
      } else {
        initiateDeathReportToServer(value.geometry!.location.lat,
            value.geometry!.location.lng, value.formattedAddress ?? "",userRole);
      }

    }).onError((error, stackTrace) {
      onApiResponseCompleted();
      var customError = GeneralError(
        message: ApiMessages.locationAddressError,
      );
      showAppThemedDialog(customError,
          buttonText: AppStrings.shareOnlyLatLng,
          onPressed: () => sendPositionCoordinates(userRole));
    });
  }

  sendPositionCoordinates(UserRole userRole) async {
    onApiRequestStarted();
    googleMapScreenController.getPositionPoints().then((value) async {
      List<Placemark> placeMarksList =
          await placemarkFromCoordinates(value.latitude, value.longitude);

      Placemark place = placeMarksList[0];
      var currentAddress =
          "${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}";

      print("Force Location ==> ${currentAddress}");

      initiateDeathReportToServer(value.latitude, value.longitude, currentAddress,userRole);
    }).onError((error, stackTrace) {
      print(error);
      onErrorShowDialog(error);
    });
  }

  initiateDeathReportToServer(double lat, double lng, String currentAddress,UserRole userRole) {
    deathReportRepo
        .initiateDeathReport(
            deathBodyCount: deathNumberCount,
            locationId: selectedGeneralLocation?.id ?? 0,
            lat: lat,
            lng: lng,
            address: currentAddress,
    userRole: userRole)
        .then((response) async {
      onApiResponseCompleted();

      var locationShareAlert =
          GeneralError(title: "", message: response.message);
      showAppThemedDialog(locationShareAlert,
          dissmisableDialog: false, showErrorMessage: false, onPressed: () {

            showQRCodeScannerScreen( response.deathReportId);
          });


    }).onError<CustomError>((error, stackTrace) async {
      onErrorShowDialog(error);
    });
  }

  showQRCodeScannerScreen(int deathReportId,{Function(dynamic)? onApiCallBack}) {
    Go.to(() => AiBarcodeScanner(
      deathReportId: deathReportId,
           userRole: currentUserRole,
          onApiCallBack: onApiCallBack,
          canPop: false,
          onScan: (String value) {
            if (isScanCodeCompleted == false) {
              isScanCodeCompleted = true;

            }
            onUpdateUI();
          },
        ));
  }

  postQRCodeToServer(String qrCode, int deathReportId, UserRole userRole,
      void Function(dynamic)? onApiCallBack) {
    onApiRequestStarted();
    deathReportRepo.postQRScanCode(qrCode,userRole).then((value) {
      isScanCodeCompleted = false;
      onApiResponseCompleted();

      if (currentUserRole == UserRole.volunteer) {
        Go.off(() => DeathReportFormScreen(
            deathBodyBandCode: value['band_code'],
            deathFormCode: deathReportId));
      } else {
        if (onApiCallBack != null) {
          onApiCallBack(value["processingCenters"]);
        }
      }


    }).onError<CustomError>((error, stackTrace) async {
      isScanCodeCompleted = false;
      onErrorShowDialog(error);
    });
  }

  postDeathReportFormToServer(
      int deathReportId, int bandCodeId, Gender gender,UserRole userRole) {
    var request = DeathReportFormRequest(
        deathReportId: deathReportId,
        visaTypeId: selectedVisaType?.id ?? 0,
        bandCodeId: bandCodeId,
        idNumber: idNumber,
        genderId: gender.id,
        age: ageNumber,
        ageGroupId: selectedAgeGroup?.id ?? 0);

    onApiRequestStarted();
    deathReportRepo.postDeathReportForm(formRequest: request,userRole: userRole).then((response) {
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
          showQRCodeScannerScreen(deathReportId);
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
      print(error);
        onErrorShowDialog(error);
    });
    return deathReportList;
  }

  ////////////// Volunteer Api Section Close/////////////////


  /// ***********  Transport Api Section  *****************

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
       Go.off(()=>PickupMapScreen(dataModel: DeathReportAlert.fromJson(response['data'])));
      });

    }).onError<CustomError>((error, stackTrace) async {
      onErrorShowDialog(error);
    });
  }

  Future<ProcessingCenter?> getDetailOfProcessUnit(int deathReportId, int processingUnitID) async {
    try {
      onApiRequestStarted();
      ProcessingCenter response = await deathReportRepo.getDetailOfProcessUnit(
        deathReportId: deathReportId,
        processingUnitId: processingUnitID,
      );
      onApiResponseCompleted();
      return response;
    } catch (error) {
      if (error is CustomError) {
        onErrorShowDialog(error);
      } else {
        print('Unexpected error: $error');
      }
      return null;
    }
  }


 dropBodyToProcessingUnitByTransport(int deathReportId,int processingUnitID) async {
    onApiRequestStarted();
    await deathReportRepo.dropBodyToProcessUnityByTransport(
        deathReportId: deathReportId,processingUnitId: processingUnitID)
        .then((response) {
      onApiResponseCompleted();
      var dialogData = GeneralError(
          title: response['title'],
          message: response['message']
      );
      showAppThemedDialog(dialogData,showErrorMessage: false,dissmisableDialog: false,onPressed: (){
        Get.offAll(
            () => const DeathReportListScreen(userRole: UserRole.transport));
      });

    }).onError<CustomError>((error, stackTrace) async {
      onErrorShowDialog(error);
    });

  }
  ////////////     Transport Api Section End /////////////

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
