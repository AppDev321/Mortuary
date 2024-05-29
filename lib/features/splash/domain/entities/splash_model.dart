import 'package:equatable/equatable.dart';

import '../../../../core/utils/app_config_service.dart';

class AppConfig extends Equatable {
  AppConfig({
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
    required this.deathTypes
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
  RadioOption({
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
