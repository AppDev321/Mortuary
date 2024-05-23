import 'package:dio/dio.dart';
import 'package:mortuary/core/error/errors.dart';
import 'package:mortuary/core/network/empty_success_response.dart';
import 'package:mortuary/core/services/network_service.dart';
import 'package:mortuary/features/authentication/domain/enities/session.dart';

import '../../../../core/network/api_manager.dart';
import '../../../../core/utils/utils.dart';
import '../data_source/auth_local_source.dart';
import '../data_source/auth_remote_source.dart';

class AuthenticationRepo {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final ApiManager apiManager;

  AuthenticationRepo({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.apiManager,
  });

  Future<Session> login({
    required String emailAddress,
    required String password,
  }) async {
    return apiManager.handleRequest(() async {
      final session = await remoteDataSource.login(
        emailAddress: emailAddress,
        password: password,
      );

      if (session is! CustomError) {
        await localDataSource.saveSession(session);
      }
      return session;
    });
  }

  Future<EmptyResponse> forgotPassword({
    required String emailAddress,
    required String phoneNumber,
  }) async {
    return apiManager.handleRequest(() async {
      return await remoteDataSource.forgotPassword(
        emailAddress: emailAddress,
        phoneNumber: phoneNumber,
      );
    });
  }
}
