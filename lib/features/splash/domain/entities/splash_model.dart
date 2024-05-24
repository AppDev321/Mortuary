import 'package:equatable/equatable.dart';

import '../../../../core/utils/common_api_data.dart';

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
  });

  final List<RadioOption> ageGroup;
  final List<RadioOption> genders;
  final List<RadioOption> languages;
  final List<RadioOption> roles;
  final List<RadioOption> statuses;
  final List<RadioOption> unitTypes;
  final List<RadioOption> vehicleTypes;
  final List<RadioOption> visaTypes;

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
      ];
}

class RadioOption extends Equatable {
  RadioOption({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory RadioOption.fromJson(Map<String, dynamic> json) {
    return RadioOption(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
      ];
}
