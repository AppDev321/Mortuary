import 'package:get/get.dart';
import 'package:mortuary/features/authentication/presentation/get/auth_controller.dart';
import 'package:mortuary/features/death_report/presentation/get/death_report_controller.dart';

import 'features/death_report/init_death_report.dart';
import 'features/navigationbar/init_splash.dart';

initMain() {
  initSplash();
  initDeathReport();
}

removeAll() {
Get.delete<DeathReportController>();
Get.delete<AuthController>();

}
