
import 'package:mortuary/core/error/errors.dart';
import 'package:mortuary/core/network/empty_success_response.dart';
import 'package:mortuary/features/authentication/domain/enities/session.dart';
import '../../../../core/network/api_manager.dart';
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


  Future<EmptyResponse> verifyOTP({
    required String emailAddress,
    required String phoneNumber,
    required int otpCode
  }) async {
    return apiManager.handleRequest(() async {
      return await remoteDataSource.verifyOTP(
        emailAddress: emailAddress,
        phoneNumber: phoneNumber,
        otpCode: otpCode
      );
    });
  }

  Future<EmptyResponse> resetPassword({
    required String emailAddress,
    required String phoneNumber,
    required String password,
    required String confirmPassword
  }) async {
    return apiManager.handleRequest(() async {
      return await remoteDataSource.resetPassword(
          emailAddress: emailAddress,
          phoneNumber: phoneNumber,
          confirmPassword: confirmPassword,
        password: password
      );
    });
  }
}
