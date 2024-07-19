import 'package:equatable/equatable.dart';

class EmptyResponse extends Equatable {
  const EmptyResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool status;
  final String message;
  final dynamic data;

  factory EmptyResponse.fromJson(Map<String, dynamic> json){
    return EmptyResponse(
      status: json["status"] ?? false,
      message: json["message"] ?? "",
      data: json["data"] ?? "",
    );
  }

  @override
  List<Object?> get props => [
    status, message, data, ];
}
