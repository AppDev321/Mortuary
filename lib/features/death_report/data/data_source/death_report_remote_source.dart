import 'package:geolocator/geolocator.dart';
import 'package:mortuary/core/network/empty_success_response.dart';

import '../../../../core/constants/app_urls.dart';
import '../../../../core/network/api_manager.dart';

abstract class DeathReportRemoteSource {
  Future<EmptyResponse> volunteerDeathReport(
      int deathBodyCount, int locationId, Position latLng);
}

class DeathReportRemoteSourceImpl implements DeathReportRemoteSource {
  final ApiManager apiManager;

  DeathReportRemoteSourceImpl(
    this.apiManager,
  );

  @override
  Future<EmptyResponse> volunteerDeathReport(
      int deathBodyCount, int locationId, Position latLng) async {
    final Map<String, dynamic> jsonMap = {
      "no_of_deaths": deathBodyCount,
      "general_location_id": locationId,
      "latitude": latLng.latitude,
      "longitude": latLng.longitude
    };

    return await apiManager.makeApiRequest<EmptyResponse>(
      url: AppUrls.volunteerDeathReportUrl,
      method: RequestMethod.POST,
      data: jsonMap,
      fromJson: (json) => EmptyResponse.fromJson(json['data']),
    );
  }
}
