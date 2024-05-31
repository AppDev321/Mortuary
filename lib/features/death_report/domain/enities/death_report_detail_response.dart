import 'package:equatable/equatable.dart';
import 'package:mortuary/features/document_upload/domain/entity/attachment_type.dart';


class DeathReportDetailResponse extends Equatable {
  DeathReportDetailResponse({
    required this.alerts,
    required this.emergency,
    required this.morgue,
    required this.attachments,
  });

  final DeathAlertDetail? alerts;
  final EmergencyDetail? emergency;
  final MorgueDetail? morgue;
  final List<AttachmentType> attachments;

  factory DeathReportDetailResponse.fromJson(Map<String, dynamic> json){
    return DeathReportDetailResponse(
      alerts: json["Alerts"] == null ? null : DeathAlertDetail.fromJson(json["Alerts"]),
      emergency: json["Emergency"] == null ? null : EmergencyDetail.fromJson(json["Emergency"]),
      morgue: json["Morgue"] == null ? null : MorgueDetail.fromJson(json["Morgue"]),
      attachments: json["Attachments"] == null ? [] : List<AttachmentType>.from(json["Attachments"]!.map((x) => AttachmentType.fromJson(x))),
    );
  }

  @override
  List<Object?> get props => [
    alerts, emergency, morgue, attachments, ];
}

class DeathAlertDetail extends Equatable {
  DeathAlertDetail({
    required this.bandCode,
    required this.visaType,
    required this.idNumber,
    required this.nationality,
    required this.gender,
    required this.age,
    required this.ageGroup,
    required this.deathType,
    required this.generalizeLocation,
    required this.reportDate,
    required this.reportTime,
    required this.address,
  });

  final String bandCode;
  final String visaType;
  final String idNumber;
  final String nationality;
  final String gender;
  final int age;
  final String ageGroup;
  final String deathType;
  final String generalizeLocation;
  final String reportDate;
  final String reportTime;
  final String address;

  factory DeathAlertDetail.fromJson(Map<String, dynamic> json){
    return DeathAlertDetail(
      bandCode: json["band_code"] ?? "",
      visaType: json["visa_type"] ?? "",
      idNumber: json["id_number"] ?? "",
      nationality: json["nationality"] ?? "",
      gender: json["gender"] ?? "",
      age: json["age"] ?? 0,
      ageGroup: json["age_group"] ?? "",
      deathType: json["death_type"] ?? "",
      generalizeLocation: json["generalize_location"] ?? "",
      reportDate: json["report_date"] ?? "",
      reportTime: json["report_time"] ?? "",
      address: json["address"] ?? "",
    );
  }

  @override
  List<Object?> get props => [
    bandCode, visaType, idNumber, nationality, gender, age, ageGroup, deathType, generalizeLocation, reportDate, reportTime, address, ];
}



class EmergencyDetail extends Equatable {
  EmergencyDetail({
    required this.processingCenter,
    required this.pocName,
    required this.pocPhone,
    required this.pocEmail,
    required this.totalSpace,
    required this.availableSpace,
    required this.address,
  });

  final String processingCenter;
  final String pocName;
  final String pocPhone;
  final String pocEmail;
  final int totalSpace;
  final int availableSpace;
  final String address;

  factory EmergencyDetail.fromJson(Map<String, dynamic> json){
    return EmergencyDetail(
      processingCenter: json["processingCenter"] ?? "",
      pocName: json["poc_name"] ?? "",
      pocPhone: json["poc_phone"] ?? "",
      pocEmail: json["poc_email"] ?? "",
      totalSpace: json["total_space"] ?? 0,
      availableSpace: json["available_space"] ?? 0,
      address: json["address"] ?? "",
    );
  }

  @override
  List<Object?> get props => [
    processingCenter, pocName, pocPhone, pocEmail, totalSpace, availableSpace, address, ];
}


class MorgueDetail extends Equatable {
  MorgueDetail({
    required this.processingCenter,
    required this.pocName,
    required this.pocPhone,
    required this.pocEmail,
    required this.totalSpace,
    required this.availableSpace,
    required this.address,
  });

  final String processingCenter;
  final String pocName;
  final String pocPhone;
  final String pocEmail;
  final int totalSpace;
  final int availableSpace;
  final String address;

  factory MorgueDetail.fromJson(Map<String, dynamic> json){
    return MorgueDetail(
      processingCenter: json["processingCenter"] ?? "",
      pocName: json["poc_name"] ?? "",
      pocPhone: json["poc_phone"] ?? "",
      pocEmail: json["poc_email"] ?? "",
      totalSpace: json["total_space"] ?? 0,
      availableSpace: json["available_space"] ?? 0,
      address: json["address"] ?? "",
    );
  }

  @override
  List<Object?> get props => [
    processingCenter, pocName, pocPhone, pocEmail, totalSpace, availableSpace, address, ];
}
