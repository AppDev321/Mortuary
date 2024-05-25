class DeathReportFormRequest {
  DeathReportFormRequest({
    required this.deathReportId,
    required this.visaTypeId,
    required this.bandCodeId,
    required this.idNumber,
    required this.genderId,
    required this.age,
    required this.ageGroupId,
  });

  final int deathReportId;
  final int visaTypeId;
  final int bandCodeId;
  final String idNumber;
  final int genderId;
  final int age;
  final int ageGroupId;


  Map<String, dynamic> toJson() => {
    "death_report_id": deathReportId,
    "visa_type_id": visaTypeId,
    "band_code_id": bandCodeId,
    "id_number": idNumber,
    "gender_id": genderId,
    "age": age,
    "age_group_id": ageGroupId,
  };

}
