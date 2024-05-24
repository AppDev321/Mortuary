import 'package:get/get.dart';
import 'package:mortuary/features/splash/data/data_source/splash_data_source.dart';
import 'package:mortuary/features/splash/data/repositories/splash_repo.dart';
import 'package:mortuary/features/splash/presentation/get/splash_controller.dart';

initSplash() async {
  Get.lazyPut<SplashRepo>(
      () => SplashRepo(remoteDataSource: Get.find(), apiManager: Get.find()),
      fenix: true);

  Get.lazyPut<SplashDataSource>(() => SplashDataSourceImpl(Get.find()),
      fenix: true);

  Get.lazyPut<SplashScreenController>(
      () => SplashScreenController(splashRepo: Get.find()),fenix: true);
}
