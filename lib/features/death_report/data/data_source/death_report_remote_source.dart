import 'package:flutter_launcher_icons/config/config.dart';
import 'package:mortuary/core/utils/app_config_service.dart';
import 'package:mortuary/features/authentication/domain/enities/user_model.dart';
import 'package:mortuary/features/death_report/domain/enities/processing_center.dart';
import 'package:mortuary/features/document_upload/domain/entity/attachment_type.dart';
import 'package:mortuary/features/splash/domain/entities/splash_model.dart';

import '../../../../core/constants/app_urls.dart';
import '../../../../core/enums/enums.dart';
import '../../../../core/network/api_manager.dart';
import '../../domain/enities/death_report_alert.dart';
import '../../domain/enities/death_report_detail_response.dart';
import '../../domain/enities/death_report_form_params.dart';
import '../../domain/enities/death_report_list_reponse.dart';
import '../../domain/enities/report_a_death_response.dart';

abstract class DeathReportRemoteSource {
  Future<ReportDeathResponse> initiateDeathReport(
      int deathBodyCount, int locationId, double lat, double lng, String address, UserRole userRole);

  Future<Map<String, dynamic>> postQRScanCode(
      String qrCode, UserRole userRole, bool isMorgueScannedProcessingDepartment,bool isEmergencyReceivedABody);

  Future<Map<String, dynamic>> postDeathReportForm(
      {required DeathReportFormRequest formRequest, required UserRole userRole});

  Future<Map<String,dynamic>> getDeathReportList(UserRole userRole);

  Future<List<DeathReportAlert>> checkAnyAlertExits();
  Future<DeathReportAlert> getDeathAlertDetail({required int deathCaseID});

  Future<DeathReportDetailResponse> getDeathReportDetailsById({required int deathReportId,required UserRole userRole});

  Future<Map<String, dynamic>> acceptDeathReportAlertByTransport({required int deathReportId,required int deathCaseID});

  Future<ProcessingCenter> getDetailOfProcessUnit({required int deathReportId, required int processingUnitId,required int deathCaseID});

  Future<Map<String, dynamic>> dropBodyToProcessUnityByTransport(
      {required int deathReportId, required int processingUnitId, required int deathCaseID});

  Future<void> updateSpaceAvailabilityStatusPU({required int status});

  Future<void> updatePoliceStation(
      {required int stationId,
      required int deathReportId,
      required String bandCodeID,
      required List<int> stationPocIds});

  Future<Map<String, dynamic>> postMorgueProcessingDepartmentData(
      {required String bodyScanCode,
      required String departmentScanCode,
      required String processingUnitId,
      required String processingDepartmentID,
      required UserRole userRole});
}

class DeathReportRemoteSourceImpl implements DeathReportRemoteSource {
  final ApiManager apiManager;

  DeathReportRemoteSourceImpl(
    this.apiManager,
  );

  @override
  Future<ReportDeathResponse> initiateDeathReport(
      int deathBodyCount, int locationId, double lat, double lng, String address, UserRole userRole) async {
    final Map<String, dynamic> jsonMap = {
      "no_of_deaths": deathBodyCount,
      "general_location_id": locationId,
      "latitude": lat,
      "longitude": lng,
      "address": address
    };
    var url = userRole == UserRole.volunteer ? AppUrls.volunteerDeathReportUrl : AppUrls.emergencyDeathReportUrl;
    return await apiManager.makeApiRequest<ReportDeathResponse>(
      url: url,
      method: RequestMethod.POST,
      data: jsonMap,
      fromJson: (json) => ReportDeathResponse.fromJson(json['data'], json['message']),
    );
  }

  @override
  Future<Map<String, dynamic>> postQRScanCode(
      String qrCode, UserRole userRole, bool isMorgueScannedProcessingDepartment,bool isEmergencyReceivedABody) async {
    final Map<String, dynamic> jsonMap = {"qr_code": qrCode};

    var appUrl = userRole == UserRole.volunteer
        ? AppUrls.volunteerScanQRCodeUrl
        : UserRole.transport == userRole
            ? AppUrls.transportScanQRCodeUrl
            : UserRole.emergency == userRole && isEmergencyReceivedABody == false
                ? AppUrls.emergencyScanQRCodeUrl
              : UserRole.emergency == userRole && isEmergencyReceivedABody == true ?
                   AppUrls.scanAmbulanceBodyUrl
                : AppUrls.morgueScanQRCodeUrl;

    appUrl = isMorgueScannedProcessingDepartment == true ? AppUrls.morgueScannedProcessDepartment : appUrl;

    return await apiManager.makeApiRequest<Map<String, dynamic>>(
      url: appUrl,
      method: RequestMethod.POST,
      data: jsonMap,
      fromJson: (json) {
        Map<String, dynamic> result = {"data": json['data']};
        if (userRole == UserRole.volunteer || userRole == UserRole.emergency) {
          result["band_code"] = json['data']['band_code_id'];
        }
        if(userRole == UserRole.emergency){
         // result["stations"] = List<Station>.from(json["data"]["stations"].map((x) => Station.fromJson(x)));
          List<Station> stations = [];
          stations.add(Station.fromJson(json["data"]["station"]));
          result["stations"] = stations;
        }
        if (userRole == UserRole.transport) {
          result["processingCenters"] = json['data']['processingCenters'];
        }
        if (userRole == UserRole.morgue) {
          result["processing_center_id"] = json['data']["processing_center_id"];
          result["death_case_id"] = json['data']['death_case_id'];
        }
        if(UserRole.emergency == userRole && isEmergencyReceivedABody == true )
          {
           result["attachmentType"] =
              List<AttachmentType>.from(json["data"]["attachmentType"].map((x) => AttachmentType.fromJson(x)));
        }
        return result;
      },
    );
  }

  @override
  Future<Map<String, dynamic>> postDeathReportForm(
      {required DeathReportFormRequest formRequest, required UserRole userRole}) async {
    var appUrl = userRole == UserRole.volunteer ? AppUrls.deathReportFormUrl : AppUrls.emergencyDeathFormUrl;

    return await apiManager.makeApiRequest<Map<String, dynamic>>(
        url: appUrl,
        method: RequestMethod.POST,
        data: formRequest.toJson(),
        fromJson: (json) => {
              if (userRole == UserRole.volunteer) "remainingCount": json['extra']['remainingDeaths'],
              if (userRole == UserRole.emergency) "attachmentType": List<AttachmentType>.from(json["data"]["attachmentType"].map((x) => AttachmentType.fromJson(x))),
              "message": json['success'],
              "title": json['message']
            });
  }

  @override
  Future<Map<String,dynamic>> getDeathReportList(UserRole userRole) async {
    var appUrl = userRole == UserRole.volunteer
        ? AppUrls.volunteerDeathReportListUrl
        : userRole == UserRole.transport
            ? AppUrls.transportDeathReportListUrl
            : userRole == UserRole.emergency
                ? AppUrls.emergencyDeathReportListUrl
                : AppUrls.morgueDeathReportListUrl;

    return await apiManager.makeApiRequest<Map<String,dynamic>>(
        url: appUrl,
        method: RequestMethod.GET,
        fromJson: (json) => {
          "reports": List<DeathReportListResponse>.from(json["data"]["reports"].map((x) => DeathReportListResponse.fromJson(x))) ,
          "last_response_model" : json["data"]["last_response"] != null ?json["data"]["last_response"]["data"] : null
        });
  }

  @override
  Future<List<DeathReportAlert>> checkAnyAlertExits() async {
    return await apiManager.makeApiRequest<List<DeathReportAlert>>(
        url: AppUrls.transportAlertUrl,
        method: RequestMethod.GET,
        fromJson: (json) {
          List<DeathReportAlert> alertList = [];
          if(json["data"]["alerts"] != null)
            {
              alertList.add(DeathReportAlert.fromJson(json["data"]["alerts"]));
            }
          return alertList;
        });
  }

  @override
  Future<DeathReportAlert> getDeathAlertDetail({required int deathCaseID}) async {

    final Map<String, dynamic> jsonMap = {
      "death_case_id":deathCaseID
    };
    return await apiManager.makeApiRequest<DeathReportAlert>(
        url: AppUrls.getDeathReportByIdUrl,
        method: RequestMethod.POST,
        data: jsonMap,
        fromJson: (json) {
          return DeathReportAlert.fromJson(json['data']);
        });
  }

  @override
  Future<DeathReportDetailResponse> getDeathReportDetailsById({required UserRole userRole,required int deathReportId}) async {
    var url = userRole == UserRole.emergency
        ? AppUrls.emergencyDeathReportDetailUrl:
    userRole == UserRole.volunteer?AppUrls.volunteerDeathReportDetailUrl
        : userRole == UserRole.transport
            ? AppUrls.transportDeathReportDetailUrl
            : AppUrls.morgueDeathReportDetailUrl;

    url = url + deathReportId.toString();

    return await apiManager.makeApiRequest<DeathReportDetailResponse>(
      url: url,
      method: RequestMethod.GET,
      fromJson: (json) => DeathReportDetailResponse.fromJson(json['data']),
    );
  }

  @override
  Future<Map<String, dynamic>> acceptDeathReportAlertByTransport({required int deathReportId,required int deathCaseID}) async {
    final Map<String, dynamic> jsonMap = {
      "death_report_id": deathReportId,
      "death_case_id":deathCaseID
    };
    return await apiManager.makeApiRequest<Map<String, dynamic>>(
      url: AppUrls.acceptDeathAlertByTransportUrl,
      method: RequestMethod.POST,
      data: jsonMap,
      fromJson: (json) => {"title": json["message"], "message": json["success"], "data": json["data"]},
    );
  }

  @override
  Future<Map<String, dynamic>> dropBodyToProcessUnityByTransport(
      {required int deathReportId, required int processingUnitId,required int deathCaseID}) async {
    final Map<String, dynamic> jsonMap = {
      "death_report_id": deathReportId,
      "processing_center_id": processingUnitId,
      "death_case_id": deathCaseID

    };

    return await apiManager.makeApiRequest<Map<String, dynamic>>(
      url: AppUrls.dropBodyToProcessUnitUrl,
      method: RequestMethod.POST,
      data: jsonMap,
      fromJson: (json) => {
        "title": json["message"],
        "message": json["success"],
      },
    );
  }

  @override
  Future<ProcessingCenter> getDetailOfProcessUnit({required int deathReportId, required int processingUnitId,required int deathCaseID}) async {
    final Map<String, dynamic> jsonMap = {"death_report_id": deathReportId, "processing_center_id": processingUnitId, "death_case_id": deathCaseID};
    return await apiManager.makeApiRequest<ProcessingCenter>(
        url: AppUrls.processUnitDetailUrl,
        method: RequestMethod.POST,
        data: jsonMap,
        fromJson: (json) => ProcessingCenter.fromJson(json["data"]["processingCenters"], json["data"]));
  }

  @override
  Future<void> updateSpaceAvailabilityStatusPU({required int status}) async {
    final Map<String, dynamic> jsonMap = {"status": status};
    return await apiManager.makeApiRequest(
        url: AppUrls.emergencyAvailabilityStatus, method: RequestMethod.POST, data: jsonMap, fromJson: (json) => ());
  }

  @override
  Future<Map<String, dynamic>> postMorgueProcessingDepartmentData(
      {required String bodyScanCode,
      required String departmentScanCode,
      required String processingUnitId,
      required String processingDepartmentID,
      required UserRole userRole}) async {
    final Map<String, dynamic> jsonMap = {
      "dead_body_band_code_id": bodyScanCode,
      "processing_center_id": processingUnitId,
      "processing_unit_band_code_id": departmentScanCode,
      "status_id": processingDepartmentID
    };
    return await apiManager.makeApiRequest(
        url: AppUrls.morgueScannedProcessDepartment,
        method: RequestMethod.POST,
        data: jsonMap,
        fromJson: (json) => {"data": json['data']});
  }

  @override
  Future<void> updatePoliceStation({
      required int stationId,
      required int deathReportId,
      required String bandCodeID,
      required List<int> stationPocIds}) async {

    final Map<String, dynamic> jsonMap = {
      "band_code_id": bandCodeID,
      "police_station_id": stationId,
      "poc_ids": stationPocIds
    };

    return await apiManager.makeApiRequest(
        url: AppUrls.updatePoliceStation,
        method: RequestMethod.POST,
        data: jsonMap,
        sendJSONFormatRequest: true,
        fromJson: (json) => {"data": json['data']});
  }
}
