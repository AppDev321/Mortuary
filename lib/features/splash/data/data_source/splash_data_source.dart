
import 'package:mortuary/core/constants/app_urls.dart';

import '../../../../core/network/api_manager.dart';
import '../../domain/entities/splash_model.dart';

abstract class SplashDataSource {
  Future<AppConfig> getAppConfigurations();
}

class SplashDataSourceImpl implements SplashDataSource {
  final ApiManager apiManager;

  SplashDataSourceImpl(this.apiManager);

  @override
  Future<AppConfig> getAppConfigurations() async {
    final Map<String, dynamic> jsonMap = {
      'device_token': 'cOxgdbYHTwO0N2mdgwVW9j:-',
    };
    return await apiManager.makeApiRequest<AppConfig>(
      url: AppUrls.configUrl,
      method: RequestMethod.GET,
      data:jsonMap,
      fromJson: (json) => AppConfig.fromJson(json['data']),
    );
  }
}
