import 'package:equatable/equatable.dart';

class DeathReportListResponse extends Equatable {
  DeathReportListResponse({
    required this.bandCode,
    required this.visaType,
    required this.idNumber,
    required this.gender,
    required this.ageGroup,
    required this.age,
    required this.status,
    required this.reportDate,
    required this.reportTime,
    required this.nationality,
    required this.deathType
  });

  final String bandCode;
  final String visaType;
  final String idNumber;
  final String gender;
  final String ageGroup;
  final String age;
  final Status status;
  final String reportDate;
  final String reportTime;
  final String nationality;
  final String deathType;

  factory DeathReportListResponse.fromJson(Map<String, dynamic> json){
    return DeathReportListResponse(
      bandCode: json["band_code"] ?? "",
      visaType: json["visa_type"] ?? "",
      idNumber: json["id_number"] ?? "",
      gender: json["gender"] ?? "",
      ageGroup: json["age_group"] ?? "",
      age: json["age"] ?? "",
      status: Status.fromJson(json["status"]),
      reportDate: json["report_date"] ?? "",
      reportTime: json["report_time"] ?? "",
      deathType: json["death_type"] ?? "",
      nationality: json["nationality"] ?? "",
    );
  }

  @override
  List<Object?> get props => [
    bandCode, visaType, idNumber, gender, ageGroup, age, status, reportDate, reportTime, ];
}

class Status extends Equatable {
  Status({
    required this.name,
    required this.color,
  });

  final String name;
  final String color;

  factory Status.fromJson(Map<String, dynamic> json){
    return Status(
      name: json["name"] ?? "",
      color: json["color"] ?? "",
    );
  }

  @override
  List<Object?> get props => [
    name, color, ];
}
