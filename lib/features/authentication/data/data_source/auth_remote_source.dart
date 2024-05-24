import 'package:dio/dio.dart';
import 'package:mortuary/features/authentication/domain/enities/session.dart';

import '../../../../core/constants/app_urls.dart';
import '../../../../core/error/errors.dart';
import '../../../../core/network/api_manager.dart';
import '../../../../core/network/empty_success_response.dart';
import 'auth_local_source.dart';

abstract class AuthRemoteDataSource {

  Future<Session> isLoggedIn();
  Future updateLocalUser(Session userModel);
  Future<bool> logout(String? token);
  Future saveSession(Session sessionModel);




  Future<Session> login({
    required String emailAddress,
    required String password,
  });

  Future<EmptyResponse> forgotPassword({
    required String emailAddress,
    required String phoneNumber,
  });

  Future<EmptyResponse> verifyOTP({
    required String emailAddress,
    required String phoneNumber,
    required int otpCode
  });

  Future<EmptyResponse> resetPassword({
    required String emailAddress,
    required String phoneNumber,
    required String password,
    required String confirmPassword
  });



}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiManager apiManager;
  final AuthLocalDataSource localDataSource;
  AuthRemoteDataSourceImpl(this.apiManager, this.localDataSource);


  ///  ****  Local Saved User operations *****

  @override
  Future updateLocalUser(Session sessionModel) async {
    try {
      return await localDataSource.saveSession(sessionModel);
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

  @override
  Future<Session> isLoggedIn() async {
    final session = await localDataSource.getSession()!;
    return session;
  }


  @override
  Future<bool> logout(String? token) async {
    await localDataSource.removeSession();
    return true;
  }

  @override
  Future saveSession(Session sessionModel) async {
    await localDataSource.saveSession(sessionModel);
  }



  ///****************** End local Store Session ****************

  @override
  Future<Session> login({
    required String emailAddress,
    required String password,
  }) async {
    final Map<String, dynamic> jsonMap = {
      'email': emailAddress,
      'password': password,
      'device_token': 'cOxgdbYHTwO0N2mdgwVW9j:-',
      'device_type': 'android',
      'device_id': ':--NTwE6PrZ_J',
    };

    return await apiManager.makeApiRequest<Session>(
      url: AppUrls.loginUrl,
      method: RequestMethod.POST,
      data: jsonMap,
      fromJson: (json) => Session.fromJson(json['data']),
    );
  }

  @override
  Future<EmptyResponse> forgotPassword({required String emailAddress, required String phoneNumber}) async {
    final Map<String, dynamic> jsonMap = {
      'email': emailAddress,
      'phone_no': phoneNumber,
    };

    return await apiManager.makeApiRequest<EmptyResponse>(
      url: AppUrls.forgotPasswordUrl,
      method: RequestMethod.POST,
      data: jsonMap,
      fromJson: (json) => EmptyResponse.fromJson(json),
    );
  }
  @override
  Future<EmptyResponse> resetPassword({required String emailAddress, required String phoneNumber, required String password, required String confirmPassword})async {
    final Map<String, dynamic> jsonMap = {
      'email': emailAddress,
      'phone_no': phoneNumber,
      'password' : password,
      'password_confirmation':confirmPassword
    };

    return await apiManager.makeApiRequest<EmptyResponse>(
      url: AppUrls.resetPasswordUrl,
      method: RequestMethod.POST,
      data: jsonMap,
      fromJson: (json) => EmptyResponse.fromJson(json),
    );
  }

  @override
  Future<EmptyResponse> verifyOTP({required String emailAddress, required String phoneNumber, required int otpCode}) async {
    final Map<String, dynamic> jsonMap = {
      'email': emailAddress,
      'phone_no': phoneNumber,
      'otp':otpCode
    };

    return await apiManager.makeApiRequest<EmptyResponse>(
      url: AppUrls.verifyOTPUrl,
      method: RequestMethod.POST,
      data: jsonMap,
      fromJson: (json) => EmptyResponse.fromJson(json),
    );

  }
}
