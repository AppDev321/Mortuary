
import 'package:mortuary/features/navigationbar/domain/entities/splash_model.dart';

abstract class SplashRepo {
  Future<AppConfig> getSplashApi(String token);
}
