import '../../../../core/network/api_manager.dart';

abstract class DeathReportRemoteSource {}

class DeathReportRemoteSourceImpl implements DeathReportRemoteSource {
  final ApiManager apiManager;

  DeathReportRemoteSourceImpl(
    this.apiManager,
  );

  ///****************** End local Store Session ****************

// @override
// Future<Session> login({
//   required String emailAddress,
//   required String password,
// }) async {
//   final Map<String, dynamic> jsonMap = {
//     'email': emailAddress,
//     'password': password,
//     'device_token': 'cOxgdbYHTwO0N2mdgwVW9j:-',
//     'device_type': 'android',
//     'device_id': ':--NTwE6PrZ_J',
//   };
//
//   return await apiManager.makeApiRequest<Session>(
//     url: AppUrls.loginUrl,
//     method: RequestMethod.POST,
//     data: jsonMap,
//     fromJson: (json) => Session.fromJson(json['data']),
//   );
// }
}
