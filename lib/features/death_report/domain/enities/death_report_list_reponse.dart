import 'package:equatable/equatable.dart';
import 'package:mortuary/core/utils/utils.dart';


//To handle data in it
class DeathReportListResult {
  final List<DeathReportListResponse> deathReports;
  final dynamic dataModel;
  DeathReportListResult(this.deathReports, this.dataModel);
}



class DeathReportListResponse extends Equatable {
  const DeathReportListResponse({
    required this.id,
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
    required this.deathType,
    required this.deathCaseID
  });
  final int id;
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
  final int deathCaseID;

  factory DeathReportListResponse.fromJson(Map<String, dynamic> json){
    return DeathReportListResponse(
      id:json['id']??0,
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
      deathCaseID: convertToInt(json['death_case_id'])

    );
  }

  @override
  List<Object?> get props => [
    bandCode, visaType, idNumber, gender, ageGroup, age, status, reportDate, reportTime, ];
}

class Status extends Equatable {
  const Status({
    required this.statusId,
    required this.name,
    required this.color,
  });
  final int statusId;
  final String name;
  final String color;

  factory Status.fromJson(Map<String, dynamic> json){
    return Status(
      statusId:json['status_id'] ??0,
      name: json["name"] ?? "",
      color: json["color"] ?? "",
    );
  }

  @override
  List<Object?> get props => [
    statusId, name, color, ];
}
