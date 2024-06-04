import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mortuary/core/network/request_interceptor.dart';
import 'package:mortuary/features/google_map/domain/entities/user_location_model.dart';

import '../../../core/error/errors.dart';
import '../builder_ids.dart';
import '../data/repository/google_map_repo.dart';

class GoogleMapScreenController extends GetxController {
  final GoogleMapRepo googleMapRepo;

  GoogleMapScreenController({required this.googleMapRepo});

  String mapKey = 'AIzaSyC_-QEoMjifhaoXliUxgOHlS5USjHONfCA';

  late GoogleMapController googleMapController;

  String travelDistance = "N/A";
  List<LatLng> polyLines = List.empty();
  Set<Marker> locationMarkers = const <Marker>{};

  String distance = "";
  String travelTime = "";

  Future<Position> getPositionPoints() async {
    await Geolocator.requestPermission();
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<UserLocationModel> getUserCurrentPosition() async {
    await Geolocator.requestPermission();
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return await googleMapRepo.getUserCurrentLocation(position, mapKey);
  }

  locateUserCurrentPositionOnMap({bool didPolyLinesShow = false,LatLng destination = const LatLng(0,0)}) async {
    Geolocator.requestPermission().then((value) async {
      var userCurrentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      LatLng latLngPosition =
          LatLng(userCurrentPosition.latitude, userCurrentPosition.longitude);

      CameraPosition cameraPosition =
          CameraPosition(target: latLngPosition, zoom: 15);
      googleMapController
          .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
     if (didPolyLinesShow) {
        getRouteCoordinates(latLngPosition,destination);
      }

      update([updateGoogleMapScreen]);
    }).onError<CustomError>((error, stackTrace) {
      debugPrint('error is in locate user position ${error.message}');
    });
  }

  getRouteCoordinates(LatLng start, LatLng destination) async {

    googleMapRepo.getMapDetailsByLatLng(start, destination, mapKey).then((responseData){

      polyLines = responseData['polylines'];
      travelDistance = "${responseData['duration']} (${responseData['distance']})";
      distance = responseData['distance'];
      travelTime = responseData['duration'];


      final Marker marker = Marker(
        markerId: const MarkerId('you'),
        position: start,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        // Customize the marker icon if needed
        infoWindow: const InfoWindow(title: "You", snippet: '*'),
        onTap: () {
          // Handle marker tap event if needed
        },
      );

      final Marker marker2 = Marker(
        markerId: const MarkerId('Destination'),
        position: destination,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        // Customize the marker icon if needed
        infoWindow: const InfoWindow(title: "Destination", snippet: '*'),
        onTap: () {
          // Handle marker tap event if needed
        },
      );
      locationMarkers = { marker2};

      update([updateGoogleMapScreen]);
    }).onError<CustomError>((error, stackTrace) {
      debugPrint('coordinate find error --> ${error.message}');
    });


  }
}
