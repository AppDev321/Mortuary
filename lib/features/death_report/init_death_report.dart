import 'package:get/get.dart';
import 'package:mortuary/features/death_report/data/data_source/death_report_remote_source.dart';
import 'package:mortuary/features/death_report/data/repositories/death_report_repo.dart';
import 'package:mortuary/features/death_report/presentation/get/death_report_controller.dart';

initDeathReport() async {
  Get.lazyPut<DeathReportRepo>(
      () =>
          DeathReportRepo(remoteDataSource: Get.find(), apiManager: Get.find()),
      fenix: true);

  Get.lazyPut<DeathReportRemoteSource>(
      () => DeathReportRemoteSourceImpl(Get.find()),
      fenix: true);

  Get.lazyPut(() => DeathReportController(deathReportRepo: Get.find()),
      fenix: true);
}