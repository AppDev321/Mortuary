import 'package:get/get.dart';
import 'package:mortuary/core/network/dio_client.dart';
import 'package:mortuary/features/navigationbar/data/data_source/splash_data_source.dart';
import 'package:mortuary/features/navigationbar/data/repo_impl/splasy_repo_impl.dart';
import 'package:mortuary/features/navigationbar/domain/repo/splash_repo.dart';

initSplash() async {
  Get.lazyPut<SplashRepo>(
      () =>
          SplashRepoImpl(remoteDataSource: Get.find(), networkInfo: Get.find()),
      fenix: true);

  Get.lazyPut<SplashDataSource>(
      () => SplashDataSourceImpl(Get.find<DioClient>()),
      fenix: true);


}
