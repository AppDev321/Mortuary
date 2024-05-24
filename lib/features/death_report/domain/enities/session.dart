import 'package:equatable/equatable.dart';
import 'package:mortuary/core/enums/enums.dart';

class Session extends Equatable {
  final String sessionId;
  final UserRole userRoleType;
  final int loggedUserID ;
  final String loggedUserName;
  final String loggedUserEmail ;

  const Session({required this.sessionId, required this.userRoleType,required this.loggedUserEmail,required this.loggedUserID,required this.loggedUserName});

  factory Session.fromJson(json) {
    String userRoleType = json['user']['role'];
    UserRole userType = UserRoleExtension.fromString(userRoleType);
    return Session(
        sessionId: json['token'],
        userRoleType: userType,
        loggedUserEmail: json['user']['email'] ?? "",
        loggedUserID: json['user']['id'] ?? 0,
        loggedUserName: json['user']['name']);
  }

  Map<String, dynamic> toLocalJson() {
    return {
      'token': sessionId,
      'role': userRoleType.displayName,
    };
  }

  @override
  List<Object?> get props => [sessionId,userRoleType];
}
