import 'package:equatable/equatable.dart';

class AttachmentType extends Equatable {
  AttachmentType({
    required this.id,
    required this.name,
    required this.path,
  });

  final int id;
  final String name;
  String path; // Change to mutable

  factory AttachmentType.fromJson(Map<String, dynamic> json){
    return AttachmentType(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      path: json["path"] ?? "", // Ensure it is initialized
    );
  }
  @override
  List<Object?> get props => [id, name, path];
}