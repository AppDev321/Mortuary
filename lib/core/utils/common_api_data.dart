
class GenderGroup {
  int id = 0;
  String name = "";
}

List<GenderGroup> getGenderGroupList() {
  return [
    GenderGroup()..id = 1..name = "0-1 month",
    GenderGroup()..id = 2..name = "1 month-1 year",
    GenderGroup()..id = 3..name = "1-3 years",
    GenderGroup()..id = 4..name = "3-5 years",
    GenderGroup()..id = 5..name = "5-12 years",
    GenderGroup()..id = 6..name = "10-12 years",
    GenderGroup()..id = 7..name = "12-19 years",
    GenderGroup()..id = 8..name = "18-24 years",
    GenderGroup()..id = 9..name = "25-34 years",
    GenderGroup()..id = 10..name = "35-44 years",
    GenderGroup()..id = 11..name = "45-54 years",
    GenderGroup()..id = 12..name = "55-64 years",
    GenderGroup()..id = 13..name = "65-74 years",
    GenderGroup()..id = 14..name = "75-84 years",
    GenderGroup()..id = 15..name = "85 years and older",
  ];
}


class VisaType {
  int id = 0;
  String name = "";
}

List<VisaType> getVisaTypeList() {
  return [
    VisaType()..id = 1..name = "Tourist Visa",
    VisaType()..id = 2..name = "Business Visa",
    VisaType()..id = 3..name = "Umrah Visa",
    VisaType()..id = 4..name = "Hajj Visa",
  ];
}



class VehicleType {
  int id = 0;
  String name = "";
}

List<VehicleType> getVehicleTypeList() {
  return [
    VehicleType()..id = 1..name = "Van",
    VehicleType()..id = 2..name = "Hiace",
    VehicleType()..id = 3..name = "Ambulance",
    VehicleType()..id = 4..name = "Emergency Response Vehicle",
  ];
}

