import 'package:geolocator/geolocator.dart';
import 'package:mortuary/core/network/empty_success_response.dart';

import '../../../../core/constants/app_urls.dart';
import '../../../../core/network/api_manager.dart';
import '../../domain/enities/report_a_death_response.dart';

abstract class DeathReportRemoteSource {
  Future<ReportDeathResponse> volunteerDeathReport(
      int deathBodyCount, int locationId, double lat, double lng,String address);
}

class DeathReportRemoteSourceImpl implements DeathReportRemoteSource {
  final ApiManager apiManager;

  DeathReportRemoteSourceImpl(
    this.apiManager,
  );

  @override
  Future<ReportDeathResponse> volunteerDeathReport(
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
}
