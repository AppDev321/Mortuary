
class RadioOption {
  int id = 0;
  String name = "";
}

List<RadioOption> getGenderGroupList() {
  return [
    RadioOption()..id = 1..name = "0-1 month",
    RadioOption()..id = 2..name = "1 month-1 year",
    RadioOption()..id = 3..name = "1-3 years",
    RadioOption()..id = 4..name = "3-5 years",
    RadioOption()..id = 5..name = "5-12 years",
    RadioOption()..id = 6..name = "10-12 years",
    RadioOption()..id = 7..name = "12-19 years",
    RadioOption()..id = 8..name = "18-24 years",
    RadioOption()..id = 9..name = "25-34 years",
    RadioOption()..id = 10..name = "35-44 years",
    RadioOption()..id = 11..name = "45-54 years",
    RadioOption()..id = 12..name = "55-64 years",
    RadioOption()..id = 13..name = "65-74 years",
    RadioOption()..id = 14..name = "75-84 years",
    RadioOption()..id = 15..name = "85 years and older",
  ];
}


List<RadioOption> getVisaTypeList() {
  return [
    RadioOption()..id = 1..name = "Tourist Visa",
    RadioOption()..id = 2..name = "Business Visa",
    RadioOption()..id = 3..name = "Umrah Visa",
    RadioOption()..id = 4..name = "Hajj Visa",
  ];
}



List<RadioOption> getVehicleTypeList() {
  return [
    RadioOption()..id = 1..name = "Van",
    RadioOption()..id = 2..name = "Hiace",
    RadioOption()..id = 3..name = "Ambulance",
    RadioOption()..id = 4..name = "Emergency Response Vehicle",
  ];
}

List<RadioOption> getGeneralizeLocation() {
  return [
    RadioOption()..id = 1..name = "Van",
    RadioOption()..id = 2..name = "Hiace",
    RadioOption()..id = 3..name = "Ambulance",
    RadioOption()..id = 4..name = "Emergency Response Vehicle",
  ];
}

