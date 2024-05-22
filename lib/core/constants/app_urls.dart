import 'package:get/get.dart';

class AppUrls {
  static const baseUrl = 'https://rideone.app/';
  static const imgUrl = 'https://rideone.app';
  static const testUrl = "${baseUrl}api/v1/";
  static const socketIOUrl = "";

  /// google maps url

  static const urlGetUserLocation =
      "https://maps.googleapis.com/maps/api/geocode/json?latlng=";

  static const urlAutoCompleteSearch =
      "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=";

  static const urlPlaceId =
      "https://maps.googleapis.com/maps/api/place/details/json?place_id=";

  static const countryCode = '&language=en&sensor=true';
}

imageUrl(String model, int id) =>
    "${AppUrls.baseUrl}storage/vehicle/$model-$id-1706770935.png";
