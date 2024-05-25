import 'package:get/get.dart';

import 'data/data_source/google_map_source.dart';
import 'data/repository/google_map_repo.dart';
import 'get/google_map_controller.dart';

initGoogleMaps() async {
  Get.lazyPut<GoogleMapRepo>(
      () => GoogleMapRepoImpl(
          remoteDataSource: Get.find(), apiManager: Get.find()),
      fenix: true);

  Get.lazyPut<GoogleMapDataSource>(
      () => GoogleMapDataSourceImpl(Get.find()),
      fenix: true);

  Get.lazyPut(() => GoogleMapScreenController(googleMapRepo: Get.find()),
      fenix: true);
}
