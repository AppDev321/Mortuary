import 'package:equatable/equatable.dart';

class UserLocationModel extends Equatable {
  String? placeId;
  Geometry? geometry;
  String? formattedAddress;

  UserLocationModel({
    required this.placeId,
    required this.geometry,
    required this.formattedAddress,
  });

  @override
  List<Object?> get props => [placeId, geometry, formattedAddress];

  factory UserLocationModel.fromJson(Map<String, dynamic> json) {
    return UserLocationModel(
      placeId: json['place_id'],
      geometry: Geometry.fromJson(json['geometry']),
      formattedAddress: json['formatted_address'],
    );
  }
}

class Geometry extends Equatable {
  final Location location;

  const Geometry({
    required this.location,
  });

  @override
  List<Object?> get props => [location];

  factory Geometry.fromJson(Map<String, dynamic> json) {
    return Geometry(
      location: Location.fromJson(json['location']),
    );
  }
}

class Location extends Equatable {
  final double lat;
  final double lng;

  const Location({
    required this.lat,
    required this.lng,
  });

  @override
  List<Object?> get props => [lat, lng];

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      lat: json['lat'],
      lng: json['lng'],
    );
  }
}
