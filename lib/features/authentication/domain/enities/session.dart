import 'package:equatable/equatable.dart';
import 'package:mortuary/core/utils/utils.dart';

class Session extends Equatable {
  final String? sessionId;

  const Session({this.sessionId});

  factory Session.fromJson(json) {
    return Session(sessionId: json['token']);
  }

  Map<String, dynamic> toLocalJson() {
    return {
      'token': sessionId,
    };
  }

  @override
  List<Object?> get props => [sessionId];
}
