import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? name;
  final String? email;

  final double? walletBalance;
  final String? phone;
  final String? bioDescription;
  final String? status;
  final String? driverLevel;
  final double? avgRating;
  final int? totalRating;
  final String? nextToKinAdded;
  final String? vehicleAdded;
  final String? emailVerified;
  final String? idVerified; // Added field

  User({
    required this.name,
    required this.email,
    required this.walletBalance,
    required this.phone,
    required this.bioDescription,
    required this.status,
    required this.driverLevel,
    required this.avgRating,
    required this.totalRating,
    required this.nextToKinAdded,
    required this.vehicleAdded,
    required this.emailVerified,
    required this.idVerified, // Added field
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      walletBalance: json['wallet_balance'] != null
          ? double.parse(json['wallet_balance'])
          : null,
      phone: json['phone'],
      bioDescription: json['bio_description'],
      status: json['status'],
      driverLevel: json['driver_level'],
      avgRating:
      json['avg_rating'] != null ? double.parse(json['avg_rating']) : null,
      totalRating:
      json['total_rating'] != null ? int.parse(json['total_rating']) : null,
      nextToKinAdded: json['next_to_kin_added'],
      vehicleAdded: json['vehicle_added'],
      emailVerified: json['email_verified'],
      idVerified: json['id_verified'], // Added field
    );
  }

  User copyWith({
    String? name,
    String? email,
    double? walletBalance,
    String? phone,
    String? bioDescription,
    String? status,
    String? driverLevel,
    double? avgRating,
    int? totalRating,
    String? nextToKinAdded,
    String? vehicleAdded,
    String? emailVerified,
    String? idVerified, // Added field
  }) {
    return User(
      name: name ?? this.name,
      email: email ?? this.email,
      walletBalance: walletBalance ?? this.walletBalance,
      phone: phone ?? this.phone,
      bioDescription: bioDescription ?? this.bioDescription,
      status: status ?? this.status,
      driverLevel: driverLevel ?? this.driverLevel,
      avgRating: avgRating ?? this.avgRating,
      totalRating: totalRating ?? this.totalRating,
      nextToKinAdded: nextToKinAdded ?? this.nextToKinAdded,
      vehicleAdded: vehicleAdded ?? this.vehicleAdded,
      emailVerified: emailVerified ?? this.emailVerified,
      idVerified: idVerified ?? this.idVerified, // Added field
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'wallet_balance': walletBalance?.toString(),
      'phone': phone,
      'bio_description': bioDescription,
      'status': status,
      'driver_level': driverLevel,
      'avg_rating': avgRating?.toString(),
      'total_rating': totalRating?.toString(),
      'next_to_kin_added': nextToKinAdded,
      'vehicle_added': vehicleAdded,
      'email_verified': emailVerified,
      'id_verified': idVerified, // Added field
    };
  }

  @override
  List<Object?> get props => [
    name,
    email,
    walletBalance,
    phone,
    bioDescription,
    status,
    driverLevel,
    avgRating,
    totalRating,
    nextToKinAdded,
    vehicleAdded,
    emailVerified,
    idVerified, // Added field
  ];
}
