import 'package:equatable/equatable.dart';


class AppConfig extends Equatable {
  const AppConfig({
    required this.ageGroup,
    required this.genders,
    required this.languages,
    required this.roles,
    required this.statuses,
    required this.unitTypes,
    required this.vehicleTypes,
    required this.visaTypes,
    required this.generalLocation,
    required this.countries,
    required this.deathTypes,
    required this.stations
  });

  final List<RadioOption> ageGroup;
  final List<RadioOption> genders;
  final List<RadioOption> languages;
  final List<RadioOption> roles;
  final List<RadioOption> statuses;
  final List<RadioOption> unitTypes;
  final List<RadioOption> vehicleTypes;
  final List<RadioOption> visaTypes;
  final List<RadioOption> generalLocation;
  final List<RadioOption> deathTypes;
  final List<RadioOption> countries;
  final List<Station> stations;

  factory AppConfig.fromJson(Map<String, dynamic> json) {

    return AppConfig(
      ageGroup: json["age_groups"] == null
          ? []
          : List<RadioOption>.from(
              json["age_groups"]!.map((x) => RadioOption.fromJson(x))),
      genders: json["genders"] == null
          ? []
          : List<RadioOption>.from(
              json["genders"]!.map((x) => RadioOption.fromJson(x))),
      languages: json["languages"] == null
          ? []
          : List<RadioOption>.from(
              json["languages"]!.map((x) => RadioOption.fromJson(x))),
      roles: json["roles"] == null
          ? []
          : List<RadioOption>.from(
              json["roles"]!.map((x) => RadioOption.fromJson(x))),
      statuses: json["statuses"] == null
          ? []
          : List<RadioOption>.from(
              json["statuses"]!.map((x) => RadioOption.fromJson(x))),
      unitTypes: json["unit_types"] == null
          ? []
          : List<RadioOption>.from(
              json["unit_types"]!.map((x) => RadioOption.fromJson(x))),
      vehicleTypes: json["vehicle_types"] == null
          ? []
          : List<RadioOption>.from(
              json["vehicle_types"]!.map((x) => RadioOption.fromJson(x))),
      visaTypes: json["visa_types"] == null
          ? []
          : List<RadioOption>.from(
              json["visa_types"]!.map((x) => RadioOption.fromJson(x))),
      generalLocation: json["generalLocations"] == null
          ? []
          : List<RadioOption>.from(
          json["generalLocations"]!.map((x) => RadioOption.fromJson(x))),
      deathTypes: json["deathTypes"] == null
          ? []
          : List<RadioOption>.from(
          json["deathTypes"]!.map((x) => RadioOption.fromJson(x))),
      countries: json["countries"] == null
          ? []
          : List<RadioOption>.from(
          json["countries"]!.map((x) => RadioOption.fromJson(x))),
      stations: json["stations"] == null ? [] : List<Station>.from(json["stations"]!.map((x) => Station.fromJson(x))),

    );
  }

  @override
  List<Object?> get props => [
        ageGroup,
        genders,
        languages,
        roles,
        statuses,
        unitTypes,
        vehicleTypes,
        visaTypes,
    generalLocation,
    countries,
    deathTypes
      ];
}

class RadioOption extends Equatable {
  const RadioOption({
    required this.id,
    required this.name,
    required this.nationality
  });

  final int id;
  final String name;
  final String nationality;


  factory RadioOption.fromJson(Map<String, dynamic> json) {
    return RadioOption(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
        nationality : json["nationality"] ?? ""
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
    nationality
      ];
}

class Station extends Equatable {
  const Station({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.pocs,
  });

  final int id;
  final String name;
  final String latitude;
  final String longitude;
  final String address;
  final List<StationPoc> pocs;

  factory Station.fromJson(Map<String, dynamic> json){
    return Station(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      latitude: json["latitude"] ?? "",
      longitude: json["longitude"] ?? "",
      address: json["address"] ?? "",
      pocs: json["pocs"] == null ? [] : List<StationPoc>.from(json["pocs"]!.map((x) => StationPoc.fromJson(x))),
    );
  }

  @override
  List<Object?> get props => [
    id, name, latitude, longitude, address, pocs, ];
}

class StationPoc extends Equatable {
  const StationPoc({
    required this.id,
    required this.name,
    required this.contactNo,
    required this.email,
    required this.shiftStartTime,
    required this.shiftEndTime,
  });

  final int id;
  final String name;
  final String contactNo;
  final dynamic email;
  final dynamic shiftStartTime;
  final dynamic shiftEndTime;

  factory StationPoc.fromJson(Map<String, dynamic> json){
    return StationPoc(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      contactNo: json["contact_no"] ?? "",
      email: json["email"],
      shiftStartTime: json["shift_start_time"],
      shiftEndTime: json["shift_end_time"],
    );
  }

  @override
  List<Object?> get props => [
    id, name, contactNo, email, shiftStartTime, shiftEndTime, ];
}

