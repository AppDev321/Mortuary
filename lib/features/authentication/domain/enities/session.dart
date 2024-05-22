import 'package:equatable/equatable.dart';
import 'package:mortuary/core/utils/utils.dart';

class Session extends Equatable {
  final String? sessionId;

  const Session({this.sessionId});

  factory Session.fromJson(json) {
    return Session(sessionId: json['access_token']);
  }

  Map<String, dynamic> toLocalJson() {
    return {
      'access_token': sessionId,
    };
  }

  @override
  List<Object?> get props => [sessionId];
}
