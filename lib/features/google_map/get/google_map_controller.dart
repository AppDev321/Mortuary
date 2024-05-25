import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:mortuary/features/google_map/domain/entities/user_location_model.dart';

import '../data/repository/google_map_repo.dart';


class GoogleMapScreenController extends GetxController {
  final GoogleMapRepo googleMapRepo;
  GoogleMapScreenController({required this.googleMapRepo});


  String mapKey = 'AIzaSyDGtzkQwow5PFUaZhOXg46a0-h-LFlQMHc';



  Future<Position> getPositionPoints() async {
    await  Geolocator.requestPermission();
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  Future<UserLocationModel> getUserCurrentPosition() async {
    await  Geolocator.requestPermission();
    var position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return await googleMapRepo.getUserCurrentLocation(position, mapKey);
  }

}
