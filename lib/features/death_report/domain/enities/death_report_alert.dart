
import 'package:equatable/equatable.dart';

import '../../../../core/utils/utils.dart';

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
    required this.deathCaseId,
    required this.distance,
    required this.duration
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
  final String distance;
  final String duration;

  factory DeathReportAlert.fromJson(Map<String, dynamic> json){

    int deathCaseId = convertToInt(json['death_case_id']);
    int deathReportId = convertToInt(json['death_report_id']);
    int noOfDeaths = convertToInt(json['no_of_deaths']);
    int volunteerId = convertToInt(json['volunteer_id']);
    double lat = convertToDouble(json['latitude']);
    double lng = convertToDouble(json['latitude']);


    return DeathReportAlert(
      deathCaseId: deathCaseId,
      deathReportId: deathReportId,
      volunteerId: volunteerId,
      generalLocation: json["general_location"] ?? "",
      latitude: lat,
      longitude: lng,
      address: json["address"],
      noOfDeaths: noOfDeaths.toString(),
      reportDate: json["report_date"] ?? "",
      reportTime: json["report_time"] ?? "",
      volunteerContactNumber: json['volunteer_contact_no'] ??"",
      distance: json["distance"] ?? "",
      duration: json["duration"] ?? "",
    );
  }


  Map<String, dynamic> toJson() => {
    "death_case_id": deathCaseId,
    "death_report_id": deathReportId,
    "volunteer_id": volunteerId,
    "distance": distance,
    "duration": duration,
    "volunteer_contact_no": volunteerContactNumber,
    "general_location": generalLocation,
    "latitude": latitude,
    "longitude": longitude,
    "address": address,
    "no_of_deaths": noOfDeaths,
    "report_date": reportDate,
    "report_time": reportTime,
  };


  @override
  List<Object?> get props => [
    deathReportId, volunteerId, generalLocation, latitude, longitude, address, noOfDeaths, reportDate, reportTime,volunteerContactNumber,distance,duration ];
}