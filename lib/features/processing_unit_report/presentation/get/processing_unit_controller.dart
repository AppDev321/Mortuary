import 'dart:convert';

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
import 'package:mortuary/features/death_report/presentation/get/death_report_controller.dart';
import 'package:mortuary/features/death_report/presentation/widget/common/death_report_list_screen.dart';

import '../../../../../core/error/errors.dart';
import '../../../../../core/popups/show_popups.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/utils.dart';
import '../../../death_report/data/repositories/death_report_repo.dart';
import '../../../death_report/domain/enities/death_report_alert.dart';
import '../../../document_upload/domain/entity/attachment_type.dart';
import '../../../document_upload/init_upload.dart';
import '../../../document_upload/presentation/widget/document_upload_screen.dart';
import '../../../google_map/get/google_map_controller.dart';
import '../../../qr_scanner/presentation/widget/ai_barcode_scanner.dart';
import '../../../splash/domain/entities/splash_model.dart';
import '../../builder_ids.dart';

import '../widget/processing_unit/death_report_form.dart';
import '../widget/processing_unit/home_screen.dart';
import '../widget/processing_unit/police_station_screen.dart';

class ProcessingUnitController extends GetxController {
  final DeathReportRepo deathReportRepo;
  final GoogleMapScreenController googleMapScreenController;

  ProcessingUnitController(
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


  Station? selectedPoliceStation;
  void setPoliceStation(Station station) => selectedPoliceStation = station;


  int ageNumber = 0;
  void setAgeNumber(String age) =>
      ageNumber = int.parse(age.isEmpty ? "0" : age);

  String idNumber = "";
  void setIdNumber(String number) => idNumber = number;

  bool isBedSpaceAvailable = true;
   setBedSpace(bool isSpaceAvailable) {
     isBedSpaceAvailable = isSpaceAvailable;
     onUpdateUI();
     updateAvailabilityStatus(isSpaceAvailable==true?1:0);
   }


  final deathReportController =  Get.find<DeathReportController>();
  int transportScannedBodyCount = 1;

  List<DeathReportListResponse> deathReportList = [];



  /// ********  Emergency Api Section Started ///////////


  initiateDeathReport(BuildContext context,UserRole userRole , { Function(dynamic)? onApiCallBack}) async {
    onApiRequestStarted();
    googleMapScreenController.getUserCurrentPosition().then((value) async {
      debugPrint("Current Location ==> ${value.formattedAddress}");

      if (value.geometry == null) {
        var loc = await googleMapScreenController.getPositionPoints();
        initiateDeathReportToServer(
            loc.latitude, loc.longitude, value.formattedAddress ?? "",userRole,onApiCallBack: onApiCallBack);
      } else {
        initiateDeathReportToServer(value.geometry!.location.lat,
            value.geometry!.location.lng, value.formattedAddress ?? "",userRole,onApiCallBack: onApiCallBack);
      }
    }).onError((error, stackTrace) {
      onApiResponseCompleted();
      var customError = GeneralError(
        message: ApiMessages.locationAddressError,
      );
      showAppThemedDialog(customError,
          buttonText: AppStrings.shareOnlyLatLng,
          onPressed: () => sendPositionCoordinates(userRole,onApiCallBack: onApiCallBack));
    });
  }

  sendPositionCoordinates(UserRole userRole, { Function(dynamic)? onApiCallBack}) async {
    onApiRequestStarted();
    googleMapScreenController.getPositionPoints().then((value) async {
      List<Placemark> placeMarksList =
          await placemarkFromCoordinates(value.latitude, value.longitude);

      Placemark place = placeMarksList[0];
      var currentAddress =
          "${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}";

      debugPrint("Force Location ==> ${currentAddress}");

      initiateDeathReportToServer(value.latitude, value.longitude, currentAddress,userRole,onApiCallBack: onApiCallBack);
    }).onError((error, stackTrace) {
      onErrorShowDialog(error);
    });
  }

  initiateDeathReportToServer(double lat, double lng, String currentAddress,UserRole userRole, { Function(dynamic)? onApiCallBack}) {
    deathReportRepo
        .initiateDeathReport(
            deathBodyCount: 1,//deathNumberCount,
            locationId: selectedGeneralLocation?.id ?? 0,
            lat: lat,
            lng: lng,
            address: currentAddress,
    userRole: userRole)
        .then((response) async {
      onApiResponseCompleted();

      showQRCodeScannerScreen(userRole,response.deathReportId);


    }).onError<CustomError>((error, stackTrace) async {
      onErrorShowDialog(error);
    });
  }

  showQRCodeScannerScreen(UserRole userRole, int deathReportId,
      { Function(dynamic)? onApiCallBack,
      bool isMorgueScannedProcessingDepartment = false,
      bool isEmergencyReceivedABody = false

      }) {
    Go.to(() => AiBarcodeScanner(
          deathReportId: deathReportId,
          userRole: userRole,
          onApiCallBack: onApiCallBack,
          canPop: false,
           isEmergencyReceivedABody :isEmergencyReceivedABody,
          isMorgueScannedProcessingDepartment: isMorgueScannedProcessingDepartment,
          onScan: (String value) {
            if (isScanCodeCompleted == false) {
              isScanCodeCompleted = true;
            }
            onUpdateUI();
          },
        ));
  }

  postQRCodeToServer(
      String qrCode,int deathReportId,UserRole userRole,
      void Function(dynamic)? onApiCallBack,
      bool isMorgueScannedProcessingDepartment ,
      bool isEmergencyReceivedABody)

  {
    if (isMorgueScannedProcessingDepartment) {
      if (onApiCallBack != null) {
        onApiCallBack(qrCode);
      }
    } else {
      //To update scanner Button Ui because it use DeathReportController
      deathReportController.onApiRequestStarted();
      onApiRequestStarted();

      deathReportRepo.postQRScanCode(
          qrCode, userRole,
          isMorgueScannedProcessingDepartment,
          isEmergencyReceivedABody).then((value) {
        //To update scanner Button Ui because it use DeathReportController
        deathReportController.onApiResponseCompleted();
        isScanCodeCompleted = false;

        onApiResponseCompleted();

        if (onApiCallBack != null) {
          value['qr_code'] = qrCode;
          onApiCallBack(value);
        } else if (isEmergencyReceivedABody) {
          Get.off(() => PoliceStationScreen(
                deathBodyBandCode: value['band_code'],
                deathFormCode: deathReportId,
                isBodyReceivedFromAmbulance: false,
                policeStationList: value['stations'] as List<Station>,
              ));
        } else {
          Go.to(() => PUDeathReportFormScreen(deathBodyBandCode: value['band_code'], deathFormCode: deathReportId,policeStationsList: value['stations'] as List<Station>,));
        }


      }).onError<CustomError>((error, stackTrace) async {
        //To update scanner Button Ui because it use DeathReportController
        deathReportController.onApiResponseCompleted();
        isScanCodeCompleted = false;
        onErrorShowDialog(error);
      });
    }
  }


  postProcessingDepartmentScanCode(
    String departmentScanCode,
    String bodyScannedCode,
    String departmentId,
    String processingUnitId,
    UserRole userRole,
    void Function(dynamic)? onApiCallBack,
  ) {
    //To update scanner Button Ui because it use DeathReportController
    deathReportController.onApiRequestStarted();

    onApiRequestStarted();
    deathReportRepo
        .postMorgueProcessingDepartmentData(
      bodyScanCode: bodyScannedCode,
      departmentScanCode: departmentScanCode,
      userRole: userRole,
      processingUnitId: processingUnitId,
      processingDepartmentID: departmentId,
    ).then((value) {
      deathReportController.onApiResponseCompleted();
      onApiResponseCompleted();
      if (onApiCallBack != null) {
        onApiCallBack(value);
      }
    }).onError<CustomError>((error, stackTrace) async {
      deathReportController.onApiResponseCompleted();

      onErrorShowDialog(error);
    });
  }

  postDeathReportFormToServer(
      int deathReportId, int bandCodeId, Gender gender,UserRole role,List<Station> policeStationList)  {
    var request = DeathReportFormRequest(
        deathReportId: deathReportId,
        visaTypeId: selectedVisaType?.id ?? 0,
        bandCodeId: bandCodeId,
        idNumber: idNumber,
        genderId: gender.id,
        age: ageNumber,
        ageGroupId: selectedAgeGroup?.id ?? 0,
        deathTypeId: selectedDeathType?.id ??0,
        countryId: selectedNationality?.id ??0);



    onApiRequestStarted();
    deathReportRepo.postDeathReportForm(formRequest: request,userRole: role).then((response) async{
      onApiResponseCompleted();
      deathNumberCount--;


      var attachmentList = response['attachmentType'] as List<AttachmentType>;

      Get.off(() => PoliceStationScreen(
        deathBodyBandCode:bandCodeId,
        deathFormCode: deathReportId,
        isBodyReceivedFromAmbulance: false,
        policeStationList: policeStationList,
        attachmentList: attachmentList,
      ));

      /*if(attachmentList.isNotEmpty) {
        await initUpload();
        Get.to(() =>
            DocumentUploadScreen(
                currentUserRole: role,
                bandCodeId: bandCodeId,
                attachmentsTypes: attachmentList
            ));
      }
      else{
        var dialog = GeneralError(title: response['title'], message: response['message']);
        showAppThemedDialog(dialog, showErrorMessage: false, dissmisableDialog: false, onPressed: () {
          Get.offAll(() => PUHomeScreen(
                currentUserRole: role,
              ));
        });
      }*/

    }).onError<CustomError>((error, stackTrace) async {
      onErrorShowDialog(error);
      // if (deathNumberCount == 1) {
      //   var customError = GeneralError(
      //     title: "",
      //     message: AppStrings.allDeathReportsPosted,
      //   );
      //   Get.offAll(() => PUHomeScreen(currentUserRole: currentUserRole!));
      //   showAppThemedDialog(customError,
      //       showErrorMessage: false, dissmisableDialog: false, onPressed: () {
      //
      //   });
      // } else {
      //   onErrorShowDialog(error);
      // }
    });
  }

  Future<List<DeathReportListResponse>> getDeathReportList(UserRole userRole) async {
    deathReportList.clear();
    onApiRequestStarted();
   await deathReportRepo.getDeathReportList(userRole).then((response) {
     deathReportList = response.deathReports;
      onApiResponseCompleted();
    }).onError<CustomError>((error, stackTrace) async {
        onErrorShowDialog(error);
    });
    return deathReportList;
  }

  // getDetailOfReport(UserRole userRole, int reportId) async {
  //   onApiRequestStarted();
  //   await deathReportRepo.getDeathReportDetailsById(userRole: userRole, deathReportId: reportId).then((response) {
  //     print(response);
  //     onApiResponseCompleted();
  //   }).onError<CustomError>((error, stackTrace) async {
  //     onErrorShowDialog(error);
  //   });
  // }

  updateAvailabilityStatus(int status) async {
    onApiRequestStarted();
    await deathReportRepo
        .updateSpaceAvailabilityStatusPU(status: status)
        .then((value) => onApiResponseCompleted())
        .onError((error, stackTrace) => onErrorShowDialog(error));
  }


  updatePoliceStation(String bandCodeId, int stationId,int deathReportID,List<int> stationPocIds,VoidCallback onSuccess) async {
    onApiRequestStarted();
    await deathReportRepo
        .updatePoliceStation(stationId: stationId,deathReportId: deathReportID,bandCodeID: bandCodeId,stationPocIds: stationPocIds)
        .then((value){
          onApiResponseCompleted();
          onSuccess();
        })
        .onError((error, stackTrace){
          onErrorShowDialog(error);
        });

  }


  ////////////// Emnergency Api Section Close/////////////////



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
