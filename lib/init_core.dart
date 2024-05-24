import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:mortuary/core/services/network_service.dart';

import 'core/network/api_manager.dart';
import 'core/network/dio_client.dart';
import 'core/network/socket_client.dart';
import 'core/network/web_socket_client.dart';

initCore() {
  Get.lazyPut<InternetConnectionCheckerPlus>(
          () => InternetConnectionCheckerPlus(),
      fenix: true);

  Get.lazyPut<NetworkInfo>(
          () => NetworkInfoImpl(Get.find()),
      fenix: true);


  Get.lazyPut<FlutterSecureStorage>(
          () => const FlutterSecureStorage(
          aOptions: AndroidOptions(encryptedSharedPreferences: true)),
      fenix: true);

  Get.lazyPut<Dio>(() => Dio(), fenix: true);
  Get.lazyPut<DioClient>(() => DioClient( Get.find()), fenix: true);
  Get.lazyPut(() => SocketService());
  Get.lazyPut(() => WebSocketService());

  Get.lazyPut<ApiManager>(
          () => ApiManager(Get.find(), Get.find(),Get.find()),
      fenix: true);

}
