import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  Future<Map<String, dynamic>> getMapDetailsByLatLng(
      LatLng start, LatLng des, String mapKey);
}

class GoogleMapDataSourceImpl implements GoogleMapDataSource {
  final ApiManager apiManager;

  GoogleMapDataSourceImpl(this.apiManager);

  @override
  Future<UserLocationModel> getUserCurrentLocation(
      Position position, String mapKey) async {
    var url =
        '${AppUrls.urlGetUserLocation}${position.latitude},${position.longitude}&key=$mapKey';

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


  @override
  Future<Map<String, dynamic>> getMapDetailsByLatLng(LatLng start, LatLng des, String mapKey) async{
  var url =   'https://maps.googleapis.com/maps/api/directions/json?origin=${start.latitude},${start.longitude}&destination=${des.latitude},${des.longitude}&key=$mapKey';

  return await apiManager.makeApiRequest<Map<String, dynamic>>(
    url: url,
    method: RequestMethod.GET,
    fromJson: (json) {
      List<LatLng> coordinates = [];
      List steps = json["routes"][0]["legs"][0]["steps"];
      var distance = json["routes"][0]["legs"][0]['distance']['text'];
      var duration = json["routes"][0]["legs"][0]['duration']['text'];

      for (int i = 0; i < steps.length; i++) {
        String encodedPolyline = steps[i]["polyline"]["points"];
        List<LatLng> segmentCoordinates = _decodePoly(encodedPolyline);
        coordinates.addAll(segmentCoordinates);
      }

      return {
        'polylines': coordinates,
        'distance': distance,
        'duration': duration
      };
    });
  }
  List<LatLng> _decodePoly(String encoded) {
    List<LatLng> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;
    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;
      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      points.add(LatLng((lat / 1E5).toDouble(), (lng / 1E5).toDouble()));
    }
    return points;
  }
}
