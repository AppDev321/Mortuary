import 'dart:convert';


import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mortuary/features/authentication/domain/enities/session.dart';

import '../../../../core/error/errors.dart';

abstract class AuthLocalDataSource {
  Future<Session>? getSession();

  Future<void> saveSession(Session sessionModel);

  Future<void> removeSession();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  AuthLocalDataSourceImpl(this.secureStorage);

  final FlutterSecureStorage secureStorage;
  @override
  Future<Session> getSession() async {
    final userJson = await secureStorage.read(key: 'session');
    if (userJson == null) {
      return Future.error(GeneralError(title:'Session',message: 'User Not Logged In'));
    }
    return Session.fromJson(jsonDecode(userJson));
  }

  @override
  Future<void> saveSession(Session sessionModel) async {
    await secureStorage.write(
        key: 'session', value: json.encode(sessionModel.toLocalJson()));
  }

  @override
  Future<void> removeSession() async {
    await secureStorage.delete(key: 'session');
  }
}
