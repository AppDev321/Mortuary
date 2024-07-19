import 'package:get/get.dart';
import 'package:mortuary/core/utils/app_config_service.dart';
import 'package:mortuary/features/authentication/presentation/pages/login_screen.dart';
import 'package:mortuary/features/splash/builder_ids.dart';
import 'package:mortuary/features/splash/data/repositories/splash_repo.dart';

import '../../../../core/error/errors.dart';
import '../../../../core/popups/show_popups.dart';

class SplashScreenController extends GetxController {
  final SplashRepo splashRepo;

  SplashScreenController({required this.splashRepo});

  var isApiLoading = false;

   startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500));

    await Future.delayed(const Duration(milliseconds: 5000));
    getApplicationConfiguration();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

  }

  getApplicationConfiguration() async {
    isApiLoading = true;
    update([updatedSplash]);
    await splashRepo.getAppConfigurations().then((value) async {
      //set data in configuration class
      ConfigService().setConfigData(value);
       Get.off(() => LoginScreen());
    }).onError<CustomError>((error, stackTrace) async {

      // print(error.message);
      isApiLoading = false;
      update([updatedSplash]);
      update();
      showAppThemedDialog(error);
    });
  }



}
