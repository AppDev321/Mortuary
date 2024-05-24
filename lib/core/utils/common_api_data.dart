
import 'package:mortuary/features/splash/domain/entities/splash_model.dart';



class ConfigService {
  static final ConfigService _singleton = ConfigService._internal();
  AppConfig? _configData;

  factory ConfigService() {
    return _singleton;
  }

  ConfigService._internal();

  void setConfigData(AppConfig configData) {
    _configData = configData;
  }

  AppConfig? get configData => _configData;

  List<RadioOption> getAgeGroups() {
    return _configData!.ageGroup ;
  }
}