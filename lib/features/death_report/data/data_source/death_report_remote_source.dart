
import 'package:mortuary/features/death_report/domain/enities/processing_center.dart';

import '../../../../core/constants/app_urls.dart';
import '../../../../core/enums/enums.dart';
import '../../../../core/network/api_manager.dart';
import '../../domain/enities/death_report_alert.dart';
import '../../domain/enities/death_report_form_params.dart';
import '../../domain/enities/death_report_list_reponse.dart';
import '../../domain/enities/report_a_death_response.dart';

abstract class DeathReportRemoteSource {
  Future<ReportDeathResponse> initiateDeathReport(
      int deathBodyCount, int locationId, double lat, double lng,String address,UserRole userRole);
  Future<Map<String,dynamic>> postQRScanCode(String qrCode,UserRole userRole,bool isMorgueScannedProcessingDepartment);

  Future<Map<String,dynamic>> postDeathReportForm({
  required DeathReportFormRequest formRequest, required UserRole userRole});

  Future<List<DeathReportListResponse>> getDeathReportList(UserRole userRole);
  Future<List<DeathReportAlert>> checkAnyAlertExits();
  Future<DeathReportAlert> getDeathReportDetailsById({required int deathReportId});
  
  Future<Map<String,dynamic>> acceptDeathReportAlertByTransport({required int deathReportId});
  Future<ProcessingCenter> getDetailOfProcessUnit({required int deathReportId,required  int processingUnitId});
  Future<Map<String, dynamic>> dropBodyToProcessUnityByTransport({required int deathReportId,required  int processingUnitId}) ;

  Future<void> updateSpaceAvailabilityStatusPU({required int status}) ;
  Future<void> updatePoliceStation({required int stationId,required int deathReportId,required String bandCodeID,required List<int> stationPocIds}) ;

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
      int deathBodyCount, int locationId, double lat,double lng,String address,UserRole userRole) async {
    final Map<String, dynamic> jsonMap = {
      "no_of_deaths": deathBodyCount,
      "general_location_id": locationId,
      "latitude": lat,
      "longitude": lng,
      "address":address
    };
    var url = userRole == UserRole.volunteer
        ? AppUrls.volunteerDeathReportUrl
        : AppUrls.emergencyDeathReportUrl;
    return await apiManager.makeApiRequest<ReportDeathResponse>(
      url: url,
      method: RequestMethod.POST,
      data: jsonMap,
      fromJson: (json) => ReportDeathResponse.fromJson(json['data'],json['message']),
    );
  }

  @override
  Future<Map<String,dynamic>> postQRScanCode(String qrCode,UserRole userRole,bool isMorgueScannedProcessingDepartment) async {


    final Map<String, dynamic> jsonMap = {
      "qr_code": qrCode
    };

    var appUrl = userRole == UserRole.volunteer
        ? AppUrls.volunteerScanQRCodeUrl
        : UserRole.transport == userRole
            ? AppUrls.transportScanQRCodeUrl
            : UserRole.emergency == userRole
                ? AppUrls.emergencyScanQRCodeUrl
                : AppUrls.morgueScanQRCodeUrl;

    appUrl=  isMorgueScannedProcessingDepartment == true?AppUrls.morgueScannedProcessDepartment:appUrl;




    return await apiManager.makeApiRequest<Map<String,dynamic>>(
      url: appUrl,
      method: RequestMethod.POST,
      data: jsonMap, fromJson: (json) {
      Map<String, dynamic> result = {"data": json['data']};
      if (userRole == UserRole.volunteer || userRole == UserRole.emergency) {
        result["band_code"] = json['data']['band_code_id'];
      }
      if (userRole == UserRole.transport) {
        result["processingCenters"] = json['data']['processingCenters'];
      }
      if (userRole == UserRole.morgue) {
        result["processing_center_id"] = json['data']["processing_center_id"];
        result["death_case_id"] = json['data']['death_case_id'];
      }
      return result;
      },
    );
  }

  @override
  Future<Map<String,dynamic>> postDeathReportForm({required DeathReportFormRequest formRequest, required UserRole userRole}) async {

    var appUrl = userRole == UserRole.volunteer ? AppUrls.deathReportFormUrl:
   AppUrls.emergencyDeathFormUrl;

    return await apiManager.makeApiRequest<Map<String,dynamic>>(
      url: appUrl,
      method: RequestMethod.POST,
      data: formRequest.toJson(),
      fromJson: (json) => {
        if(userRole == UserRole.volunteer)
          "remainingCount":json['extra']['remainingDeaths'],
        "message":json['success'],
        "title":json['message']
      }
    );
  }

  @override
  Future<List<DeathReportListResponse>> getDeathReportList(UserRole userRole) async {
    var appUrl = userRole == UserRole.volunteer
        ? AppUrls.volunteerDeathReportListUrl
        : userRole == UserRole.transport
            ? AppUrls.transportDeathReportListUrl
            : userRole == UserRole.emergency
                ? AppUrls.emergencyDeathReportListUrl
                : AppUrls.morgueDeathReportListUrl;

    return await apiManager.makeApiRequest<List<DeathReportListResponse>>(
        url: appUrl,
        method: RequestMethod.GET,
        fromJson: (json) {
          return List.from(json["data"]["reports"].map((x) =>
              DeathReportListResponse.fromJson(x)));
        }
    );
  }

  @override
  Future<List<DeathReportAlert>> checkAnyAlertExits()async {
    return await apiManager.makeApiRequest<List<DeathReportAlert>>(
        url: AppUrls.transportAlertUrl,
        method: RequestMethod.GET,
        fromJson: (json) {
          return List.from(json["data"]["alerts"].map((x) => DeathReportAlert.fromJson(x)));
        }
    );
  }

  @override
  Future<DeathReportAlert> getDeathReportDetailsById({required int deathReportId}) async {
    final Map<String, dynamic> jsonMap = {
      "death_report_id": deathReportId
    };
    return await apiManager.makeApiRequest<DeathReportAlert>(
      url: AppUrls.volunteerScanQRCodeUrl,
      method: RequestMethod.POST,
      data: jsonMap,
      fromJson: (json) => json['data'],
    );
  }


  @override
  Future<Map<String, dynamic>> acceptDeathReportAlertByTransport({required int deathReportId}) async{
    final Map<String, dynamic> jsonMap = {
      "death_report_id": deathReportId
    };
    return await apiManager.makeApiRequest<Map<String, dynamic>>(
      url: AppUrls.acceptDeathAlertByTransportUrl,
      method: RequestMethod.POST,
      data: jsonMap,
      fromJson: (json)=>{
        "title":json["message"],
        "message":json["success"],
        "data":json["data"]
      },
    );
  }

  @override
  Future<Map<String, dynamic>> dropBodyToProcessUnityByTransport({required int deathReportId,required  int processingUnitId}) async{
    final Map<String, dynamic> jsonMap = {
      "death_report_id": deathReportId,
      "processing_center_id":processingUnitId
    };
    return await apiManager.makeApiRequest<Map<String, dynamic>>(
      url: AppUrls.dropBodyToProcessUnitUrl,
      method: RequestMethod.POST,
      data: jsonMap,
      fromJson: (json)=>{
        "title":json["message"],
        "message":json["success"],
      },
    );
  }

  @override
  Future<ProcessingCenter> getDetailOfProcessUnit({required int deathReportId, required int processingUnitId}) async {
    final Map<String, dynamic> jsonMap = {
      "death_report_id": deathReportId,
      "processing_center_id":processingUnitId
    };
    return await apiManager.makeApiRequest<ProcessingCenter>(
      url: AppUrls.processUnitDetailUrl,
      method: RequestMethod.POST,
      data: jsonMap,
      fromJson: (json)=>ProcessingCenter.fromJson(json["data"]["processingCenters"],json["extra"])
    );
  }

  @override
  Future<void> updateSpaceAvailabilityStatusPU({required int status}) async{
    final Map<String, dynamic> jsonMap = {
      "status": status
    };
    return await apiManager.makeApiRequest(
        url: AppUrls.emergencyAvailabilityStatus,
        method: RequestMethod.POST,
        data: jsonMap,
        fromJson: (json)=>()
    );
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
        fromJson: (json)=> {"data": json['data']});
  }

  @override
  Future<void> updatePoliceStation({required int stationId, required int deathReportId, required String bandCodeID,required List<int> stationPocIds})async {
    final Map<String, dynamic> jsonMap = {
      "band_code_id": bandCodeID,
      "police_station_id": stationId,
      "poc_ids":stationPocIds//.map((id) => id.toString()).join(",")
    };

    print(jsonMap);
    return await apiManager.makeApiRequest(
        url: AppUrls.updatePoliceStation,
        method: RequestMethod.POST,
        data: jsonMap,
        fromJson: (json)=> {"data": json['data']});
  }


}
