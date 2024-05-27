
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
  Future<Map<String,dynamic>> postQRScanCode(String qrCode,UserRole userRole);

  Future<Map<String,dynamic>> postDeathReportForm({
  required DeathReportFormRequest formRequest, required UserRole userRole});

  Future<List<DeathReportListResponse>> getDeathReportList(UserRole userRole);
  Future<List<DeathReportAlert>> checkAnyAlertExits();
  Future<DeathReportAlert> getDeathReportDetailsById({required int deathReportId});
  
  Future<Map<String,dynamic>> acceptDeathReportAlertByTransport({required int deathReportId});
  Future<ProcessingCenter> getDetailOfProcessUnit({required int deathReportId,required  int processingUnitId});
  Future<Map<String, dynamic>> dropBodyToProcessUnityByTransport({required int deathReportId,required  int processingUnitId}) ;



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
  Future<Map<String,dynamic>> postQRScanCode(String qrCode,UserRole userRole) async {
    var code = int.tryParse(qrCode);

    final Map<String, dynamic> jsonMap = {
      "qr_code": code ?? "-1"
    };

    var appUrl = userRole == UserRole.volunteer ? AppUrls.volunteerScanQRCodeUrl:
        UserRole.transport == userRole?AppUrls.transportScanQRCodeUrl:
        AppUrls.emergencyScanQRCodeUrl;


    return await apiManager.makeApiRequest<Map<String,dynamic>>(
      url: appUrl,
      method: RequestMethod.POST,
      data: jsonMap,
      fromJson: (json)=> {
        if(userRole == UserRole.volunteer || userRole == UserRole.emergency )
        "band_code":json['data']['band_code_id'],
        if(userRole == UserRole.transport)
        "processingCenters" : json['data']['processingCenters']
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
    var appUrl = userRole == UserRole.volunteer ? AppUrls.volunteerDeathReportListUrl:
                AppUrls.transportDeathReportListUrl;

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


}
