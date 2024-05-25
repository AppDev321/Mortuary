import 'package:equatable/equatable.dart';

class ReportDeathResponse extends Equatable {
  ReportDeathResponse(
      {required this.deathReportId,
      required this.volunteerId,
      required this.generalLocationId,
      required this.latitude,
      required this.longitude,
      required this.noOfDeaths,
      required this.reportDate,
      required this.reportTime,
      required this.message,
      required this.address});

  final int deathReportId;
  final int volunteerId;
  final int generalLocationId;
  final double latitude;
  final double longitude;
  final int noOfDeaths;
  final String reportDate;
  final String reportTime;
  final String message;
  final String address;

  factory ReportDeathResponse.fromJson(
      Map<String, dynamic> json, String message) {
    return ReportDeathResponse(
      deathReportId: json["death_report_id"] ?? 0,
      volunteerId: json["volunteer_id"] ?? 0,
      generalLocationId: int.parse(json["general_location_id"]?? "0" ),
      latitude: json["latitude"] ?? 0.0,
      longitude: json["longitude"] ?? 0.0,
      noOfDeaths: int.parse(json["no_of_deaths"] ?? "0"),
      reportDate: json["report_date"] ?? "",
      reportTime: json["report_time"] ?? "",
      address: json["address"] ?? "",
      message: message,
    );
  }

  @override
  List<Object?> get props => [
        deathReportId,
        volunteerId,
        generalLocationId,
        latitude,
        longitude,
        noOfDeaths,
        reportDate,
        reportTime,
        message,
      address
      ];
}
