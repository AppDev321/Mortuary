

class AppUrls {
  static const applicationURL = 'https://mortuary.maetech.co';
  static const baseUrl = "$applicationURL/api/";
  static const socketIOUrl = "";

  //App URLS
  static const configUrl = '${baseUrl}config';
  static const loginUrl = '${baseUrl}login';
  static const forgotPasswordUrl = '${baseUrl}forgot-password';
  static const verifyOTPUrl = '${baseUrl}verify-otp';
  static const resetPasswordUrl = '${baseUrl}reset-password';
  static const volunteerDeathReportUrl= '${baseUrl}volunteer/death-report';




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
