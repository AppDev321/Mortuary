
import 'package:equatable/equatable.dart';

class ProcessingCenter extends Equatable {
  ProcessingCenter({
    required this.processingCenterId,
    required this.centreName,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.totalSpace,
    required this.availableSpace,
    required this.policePoc,
    required this.policePhoneNo,
  });

  final int processingCenterId;
  final String centreName;
  final String address;
  final double latitude;
  final double longitude;
  final int totalSpace;
  final int availableSpace;
  final String policePoc;
  final String policePhoneNo;

  factory ProcessingCenter.fromJson(Map<String, dynamic> json){
    return ProcessingCenter(
      processingCenterId: json["processing_center_id"] ?? 0,
      centreName: json["centre_name"] ?? "",
      address: json["address"] ?? "",
      latitude: json["latitude"] ?? 0.0,
      longitude: json["longitude"] ?? 0.0,
      totalSpace: json["total_space"] ?? 0,
      availableSpace: json["available_space"] ?? 0,
      policePoc: json["police_poc"] ?? "",
      policePhoneNo: json["police_phone_no"] ?? "",
    );
  }

  @override
  List<Object?> get props => [
    processingCenterId, centreName, address, latitude, longitude, totalSpace, availableSpace, policePoc, policePhoneNo, ];
}