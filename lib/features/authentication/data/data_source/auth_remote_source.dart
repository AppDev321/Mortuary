import 'package:mortuary/features/authentication/domain/enities/session.dart';

import '../../../../core/constants/app_urls.dart';
import '../../../../core/error/errors.dart';
import '../../../../core/network/api_manager.dart';
import '../../../../core/network/base_response.dart';

abstract class AuthRemoteDataSource {
  Future<Session> login({
    required String emailAddress,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiManager apiManager;

  AuthRemoteDataSourceImpl(this.apiManager);

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

    final response = await apiManager.callNetworkApiRequest<BaseResponse>(
        url: AppUrls.loginUrl, method: RequestMethod.POST, data: jsonMap);

    if (response.error != null) {
      return Future.error(
        GeneralError(message: response.error!.message),
      );
    } else {
      final data = response.data!.data as Session;
      return data;
    }
  }
}
