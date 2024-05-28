import 'package:get/get.dart';
import 'package:mortuary/features/authentication/presentation/get/auth_controller.dart';
import 'package:mortuary/features/death_report/presentation/get/death_report_controller.dart';
import 'core/services/fcm_controller.dart';
import 'features/death_report/init_death_report.dart';
import 'features/document_upload/init_upload.dart';
import 'features/google_map/init_google_map.dart';
import 'features/splash/init_splash.dart';

initMain() {
  Get.lazyPut<FCMController>(() => FCMController(), fenix: true);
  initSplash();
  initGoogleMaps();
  initDeathReport();
  initUpload();
}

removeAll() {
  Get.delete<DeathReportController>();
  Get.delete<AuthController>();
}
