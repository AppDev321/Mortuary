import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mortuary/features/google_map/domain/entities/user_location_model.dart';

import '../../../core/error/errors.dart';
import '../builder_ids.dart';
import '../data/repository/google_map_repo.dart';


class GoogleMapScreenController extends GetxController {
  final GoogleMapRepo googleMapRepo;
  GoogleMapScreenController({required this.googleMapRepo});


  String mapKey = 'AIzaSyA80LxnzrE2fTGP_SFrkejGc9Enyz3D2oU';

  late GoogleMapController googleMapController;

  Future<Position> getPositionPoints() async {
    await  Geolocator.requestPermission();
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  Future<UserLocationModel> getUserCurrentPosition() async {
    await  Geolocator.requestPermission();
    var position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return await googleMapRepo.getUserCurrentLocation(position, mapKey);
  }

  locateUserCurrentPositionOnMap() async {
    Geolocator.requestPermission().then((value) async {
        var userCurrentPosition = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        LatLng latLngPosition = LatLng(
            userCurrentPosition.latitude, userCurrentPosition.longitude);

        CameraPosition cameraPosition =
        CameraPosition(target: latLngPosition, zoom: 15);
        googleMapController
            .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

      update([updateGoogleMapScreen]);
    }).onError<CustomError>((error, stackTrace) {
      print('error is in locate user position ${error.message}');
    });
  }



}
