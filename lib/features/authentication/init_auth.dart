import 'package:get/get.dart';
import 'package:mortuary/features/authentication/data/repositories/auth_repo_impl.dart';
import 'package:mortuary/features/authentication/presentation/get/auth_controller.dart';

import '../../core/services/picker_decider.dart';
import 'data/data_source/auth_local_source.dart';
import 'data/data_source/auth_remote_source.dart';


initAuth() async {
  Get.lazyPut<AuthenticationRepo>(
      () => AuthenticationRepo(
          remoteDataSource: Get.find(),
          localDataSource: Get.find(),
          networkInfo: Get.find()),
      fenix: true);

  // Get.lazyPut<NotificationService>(() => NotificationServiceImpl());
  Get.lazyPut<FileChooserService>(() => FileChooserServiceImpl());

  Get.lazyPut<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(Get.find()),
      fenix: true);

  Get.lazyPut<AuthLocalDataSource>(() => AuthLocalDataSourceImpl(Get.find()),
      fenix: true);

  await Get.putAsync(() async {
    final instance = AuthController(authUseRepo: Get.find());
   // await instance.init();
    return instance;
  }, permanent: true);


  //
  // Get.lazyPut(() => ForgotPasswordController(authUseRepo: Get.find()),
  //     fenix: true);
}
