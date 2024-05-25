import 'package:equatable/equatable.dart';

class PlacesApiResponse extends Equatable {
  final Geometry geometry;
  final String formattedAddress;
  final String name;
  final List<AddressComponent> addressComponents;
  bool isSelected;

  PlacesApiResponse({
    required this.geometry,
    required this.formattedAddress,
    required this.name,
    required this.addressComponents,
    this.isSelected = false,
  });

  @override
  List<Object?> get props => [geometry, formattedAddress, name, addressComponents];

  factory PlacesApiResponse.fromJson(Map<String, dynamic> json) {
    return PlacesApiResponse(
      geometry: Geometry.fromJson(json['geometry']),
      formattedAddress: json['formatted_address'] ?? '',
      name: json['name'] ?? '',
      addressComponents: (json['address_components'] as List<dynamic>)
          .map((component) => AddressComponent.fromJson(component))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'geometry': geometry.toJson(),
      'formatted_address': formattedAddress,
      'name': name,
      'address_components': addressComponents.map((component) => component.toJson()).toList(),
    };
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

  Map<String, dynamic> toJson() {
    return {
      'location': location.toJson(),
    };
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
      lat: json['lat'] ?? 0.0,
      lng: json['lng'] ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }
}

class AddressComponent extends Equatable {
  final String longName;
  final String shortName;
  final List<String> types;

  const AddressComponent({
    required this.longName,
    required this.shortName,
    required this.types,
  });

  @override
  List<Object?> get props => [longName, shortName, types];

  factory AddressComponent.fromJson(Map<String, dynamic> json) {
    return AddressComponent(
      longName: json['long_name'] ?? '',
      shortName: json['short_name'] ?? '',
      types: (json['types'] as List<dynamic>).map((type) => type.toString()).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'long_name': longName,
      'short_name': shortName,
      'types': types,
    };
  }
}
