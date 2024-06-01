
import 'package:equatable/equatable.dart';

class DeathReportAlert extends Equatable {
  DeathReportAlert({
    required this.deathReportId,
    required this.volunteerId,
    required this.generalLocation,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.noOfDeaths,
    required this.reportDate,
    required this.reportTime,
    required this.volunteerContactNumber,
    required this.deathCaseId
  });
  final int deathCaseId;
  final int deathReportId;
  final int volunteerId;
  final String generalLocation;
  final double latitude;
  final double longitude;
  final dynamic address;
  final String noOfDeaths;
  final String reportDate;
  final String reportTime;
  final String volunteerContactNumber;

  factory DeathReportAlert.fromJson(Map<String, dynamic> json){
    return DeathReportAlert(
      deathCaseId:json['death_case_id'] ?? 0,
      deathReportId: json["death_report_id"] ?? 0,
      volunteerId: json["volunteer_id"] ?? 0,
      generalLocation: json["general_location"] ?? "",
      latitude: json["latitude"] ?? 0.0,
      longitude: json["longitude"] ?? 0.0,
      address: json["address"],
      noOfDeaths: json["no_of_deaths"] ?? "",
      reportDate: json["report_date"] ?? "",
      reportTime: json["report_time"] ?? "",
      volunteerContactNumber: json['volunteer_contact_no'] ??""
    );
  }

  @override
  List<Object?> get props => [
    deathReportId, volunteerId, generalLocation, latitude, longitude, address, noOfDeaths, reportDate, reportTime,volunteerContactNumber ];
}