
import '../../../../core/constants/app_urls.dart';
import '../../../../core/enums/enums.dart';
import '../../../../core/network/api_manager.dart';
import '../../domain/enities/death_report_alert.dart';
import '../../domain/enities/death_report_form_params.dart';
import '../../domain/enities/death_report_list_reponse.dart';
import '../../domain/enities/report_a_death_response.dart';

abstract class DeathReportRemoteSource {
  Future<ReportDeathResponse> initiateDeathReport(
      int deathBodyCount, int locationId, double lat, double lng,String address);
  Future<int> postQRScanCode(String qrCode);

  Future<Map<String,dynamic>> postDeathReportForm({
  required DeathReportFormRequest formRequest});

  Future<List<DeathReportListResponse>> getDeathReportList(UserRole userRole);
  Future<List<DeathReportAlert>> checkAnyAlertExits();
  Future<DeathReportAlert> getDeathReportDetailsById({required int deathReportId});
  
  Future<Map<String,dynamic>> acceptDeathReportAlertByTransport({required int deathReportId});

}

class DeathReportRemoteSourceImpl implements DeathReportRemoteSource {
  final ApiManager apiManager;

  DeathReportRemoteSourceImpl(
    this.apiManager,
  );

  @override
  Future<ReportDeathResponse> initiateDeathReport(
      int deathBodyCount, int locationId, double lat,double lng,String address) async {
    final Map<String, dynamic> jsonMap = {
      "no_of_deaths": deathBodyCount,
      "general_location_id": locationId,
      "latitude": lat,
      "longitude": lng,
      "address":address
    };

    return await apiManager.makeApiRequest<ReportDeathResponse>(
      url: AppUrls.volunteerDeathReportUrl,
      method: RequestMethod.POST,
      data: jsonMap,
      fromJson: (json) => ReportDeathResponse.fromJson(json['data'],json['message']),
    );
  }

  @override
  Future<int> postQRScanCode(String qrCode) async {
    final Map<String, dynamic> jsonMap = {
      "qr_code": qrCode
    };
    return await apiManager.makeApiRequest<int>(
      url: AppUrls.volunteerScanQRCodeUrl,
      method: RequestMethod.POST,
      data: jsonMap,
      fromJson: (json) => json['data']['band_code_id'],
    );
  }

  @override
  Future<Map<String,dynamic>> postDeathReportForm({required DeathReportFormRequest formRequest}) async {
    return await apiManager.makeApiRequest<Map<String,dynamic>>(
      url: AppUrls.deathReportFormUrl,
      method: RequestMethod.POST,
      data: formRequest.toJson(),
      fromJson: (json) => {
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
}
