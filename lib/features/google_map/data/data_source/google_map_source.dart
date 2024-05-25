import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../core/constants/app_urls.dart';
import '../../../../core/network/api_manager.dart';
import '../../domain/entities/place_prediction_model.dart';
import '../../domain/entities/places_api_response.dart';
import '../../domain/entities/user_location_model.dart';

abstract class GoogleMapDataSource {
  Future<UserLocationModel> getUserCurrentLocation(
      Position position, String mapKey);

  Future<List<PlacePredictionModel>> findPlaceAutoCompleteSearch(
      String inputText, String mapKey);

  Future<PlacesApiResponse> findPlaceByPlaceId(String placeId, String mapKey);
}

class GoogleMapDataSourceImpl implements GoogleMapDataSource {
  final ApiManager apiManager;

  GoogleMapDataSourceImpl(this.apiManager);

  @override
  Future<UserLocationModel> getUserCurrentLocation(
      Position position, String mapKey) async {
    var url =
        '${AppUrls.urlGetUserLocation}${position.longitude},${position.latitude}&key=$mapKey';

    return await apiManager.makeApiRequest<UserLocationModel>(
      url: url,
      method: RequestMethod.GET,
      fromJson: (json) => UserLocationModel.fromJson(json['results'][0]),
    );
  }

  @override
  Future<List<PlacePredictionModel>> findPlaceAutoCompleteSearch(
      String inputText, String mapKey) async {
    final encodedInput = Uri.encodeQueryComponent(inputText);
    var url =
        '${AppUrls.urlAutoCompleteSearch}$encodedInput&location=30.3753%2C69.3451&radius=500&key=$mapKey${AppUrls.countryCode}';
    return await apiManager.makeApiRequest<List<PlacePredictionModel>>(
        url: url,
        method: RequestMethod.GET,
        fromJson: (json) => json['data']['predictions']
            .map<PlacePredictionModel>(
                (addressJson) => PlacePredictionModel.fromJson(addressJson))
            .toList());
  }

  @override
  Future<PlacesApiResponse> findPlaceByPlaceId(
      String placeId, String mapKey) async {
    var url = '${AppUrls.urlPlaceId}$placeId&key=$mapKey';

    return await apiManager.makeApiRequest<PlacesApiResponse>(
      url: url,
      method: RequestMethod.GET,
      fromJson: (json) => PlacesApiResponse.fromJson(json['data']['result']),
    );
  }
}
