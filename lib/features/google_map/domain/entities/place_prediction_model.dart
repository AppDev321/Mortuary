import 'package:equatable/equatable.dart';

class PlacePredictionModel extends Equatable {
  final String description;
  final String placeId;
  final String reference;
  final String secondaryText;

  const PlacePredictionModel({
    required this.description,
    required this.placeId,
    required this.reference,
    required this.secondaryText,
  });

  @override
  List<Object?> get props => [description, placeId, reference];

  factory PlacePredictionModel.fromJson(Map<String, dynamic> json) {
    return PlacePredictionModel(
      description: json['description'] ?? '',
      placeId: json['place_id'] ?? '',
      reference: json['reference'] ?? '',
      secondaryText: json['structured_formatting']['main_text'] ?? '', // Add this line
    );
  }
}
