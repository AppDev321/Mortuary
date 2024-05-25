
import '../../../../core/constants/app_urls.dart';
import '../../../../core/network/api_manager.dart';
import '../../domain/enities/death_report_form_params.dart';
import '../../domain/enities/death_report_list_reponse.dart';
import '../../domain/enities/report_a_death_response.dart';

abstract class DeathReportRemoteSource {
  Future<ReportDeathResponse> initiateDeathReport(
      int deathBodyCount, int locationId, double lat, double lng,String address);
  Future<int> postQRScanCode(String qrCode);
  Future<Map<String,dynamic>> postDeathReportForm({
  required DeathReportFormRequest formRequest});

  Future<List<DeathReportListResponse>> getDeathReportList();

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
  Future<List<DeathReportListResponse>> getDeathReportList() async {
    return await apiManager.makeApiRequest<List<DeathReportListResponse>>(
        url: AppUrls.volunteerDeathReportListUrl,
        method: RequestMethod.GET,
        fromJson: (json) {
         return List.from(json["data"]["reports"].map((x) => DeathReportListResponse.fromJson(x)));
        }
    );
  }
}
