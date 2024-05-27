import 'package:get/get.dart';
import 'package:mortuary/core/services/image_service.dart';
import 'package:mortuary/features/authentication/presentation/get/auth_controller.dart';
import 'package:mortuary/features/death_report/presentation/get/death_report_controller.dart';
import 'core/services/fcm_controller.dart';
import 'core/services/picker_decider.dart';
import 'features/death_report/init_death_report.dart';
import 'features/document_upload/presentation/get/document_controller.dart';
import 'features/google_map/init_google_map.dart';
import 'features/splash/init_splash.dart';

initMain() {

  Get.lazyPut<FileChooserService>(() => FileChooserServiceImpl());
  Get.lazyPut<ImageService>(() => ImageServiceImpl());


  Get.lazyPut<FCMController>(() => FCMController(),fenix: true);
  Get.lazyPut<DocumentController>(()=> DocumentController());
  initSplash();
  initGoogleMaps();
  initDeathReport();

}

removeAll() {
  Get.delete<DeathReportController>();
  Get.delete<AuthController>();
}
