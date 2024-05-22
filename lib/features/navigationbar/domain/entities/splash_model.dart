import 'package:equatable/equatable.dart';

class AppConfig extends Equatable {
  final String googleMapApiKey;
  final String termsLink;
  final String privacyLink;
  final String google_map_api_key_server;

  AppConfig({
    required this.googleMapApiKey,
    required this.termsLink,
    required this.privacyLink,
    required this.google_map_api_key_server,
  });

  @override
  List<Object?> get props =>
      [googleMapApiKey, termsLink, privacyLink, google_map_api_key_server];

  factory AppConfig.fromJson(Map<String, dynamic> json) {
    return AppConfig(
      googleMapApiKey: json['google_map_api_key'],
      termsLink: json['terms_link'],
      privacyLink: json['privacy_link'],
      google_map_api_key_server: json['google_map_api_key_server'],
    );
  }
}
