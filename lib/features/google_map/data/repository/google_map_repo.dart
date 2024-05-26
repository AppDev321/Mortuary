import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mortuary/core/network/api_manager.dart';
import '../../domain/entities/place_prediction_model.dart';
import '../../domain/entities/places_api_response.dart';
import '../../domain/entities/user_location_model.dart';
import '../data_source/google_map_source.dart';

abstract class GoogleMapRepo {
  Future<UserLocationModel> getUserCurrentLocation(
      Position position, String mapKey);

  Future<List<PlacePredictionModel>> findPlaceAutoCompleteSearch(
      String inputText, String mapKey);

  Future<PlacesApiResponse> findPlaceByPlaceId(String placeId, String mapKey);

  Future<Map<String, dynamic>> getMapDetailsByLatLng(
      LatLng start, LatLng des, String mapKey);
}

class GoogleMapRepoImpl implements GoogleMapRepo {
  final GoogleMapDataSource remoteDataSource;
  final ApiManager apiManager;

  const GoogleMapRepoImpl({
    required this.remoteDataSource,
    required this.apiManager,
  });

  @override
  Future<List<PlacePredictionModel>> findPlaceAutoCompleteSearch(
      String inputText, String mapKey) {
    return apiManager.handleRequest(() async {
      final session =
          await remoteDataSource.findPlaceAutoCompleteSearch(inputText, mapKey);
      return session;
    });
  }

  @override
  Future<PlacesApiResponse> findPlaceByPlaceId(String placeId, String mapKey) {
    return apiManager.handleRequest(() async {
      final session =
          await remoteDataSource.findPlaceByPlaceId(placeId, mapKey);
      return session;
    });
  }

  @override
  Future<UserLocationModel> getUserCurrentLocation(
      Position position, String mapKey) {
    return apiManager.handleRequest(() async {
      final session =
          await remoteDataSource.getUserCurrentLocation(position, mapKey);
      return session;
    });
  }

  @override
  Future<Map<String, dynamic>> getMapDetailsByLatLng(LatLng start, LatLng des, String mapKey) {
    return apiManager.handleRequest(() async {
      final session =
      await remoteDataSource.getMapDetailsByLatLng(start,des, mapKey);
      return session;
    });
  }
}
