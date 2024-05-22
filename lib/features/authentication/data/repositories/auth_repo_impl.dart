import 'package:dio/dio.dart';
import 'package:mortuary/core/error/errors.dart';
import 'package:mortuary/core/services/network_service.dart';
import 'package:mortuary/features/authentication/domain/enities/session.dart';

import '../../../../core/utils/utils.dart';
import '../data_source/auth_local_source.dart';
import '../data_source/auth_remote_source.dart';

class AuthenticationRepo {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AuthenticationRepo(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Session> login(
      {required String emailAddress, required String password}) async {
    await checkNetwork(networkInfo);

    try {
      final session = await remoteDataSource.login(
        emailAddress: emailAddress,
        password: password,
      );

      if (session is! CustomError) {
        await localDataSource.saveSession(session);
      }
      return session;
    } on GeneralError catch (error) {
      return Future.error(error);
    } catch (exception, stackTrace) {
      return Future.error(GeneralError(
          message: exception is DioError
              ? exception.message
              : exception is GeneralError
                  ? exception.message
                  : exception.toString(),
          stackTrace: stackTrace.toString()));
    }
  }
}
