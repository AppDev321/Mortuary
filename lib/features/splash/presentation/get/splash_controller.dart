import 'package:get/get.dart';
import 'package:mortuary/features/authentication/presentation/pages/login_screen.dart';
import 'package:mortuary/features/onboarding/presentation/pages/onboarding_screen.dart';

class SplashScreenController extends GetxController{
  static SplashScreenController get find => Get.find();


  RxBool animate = false.obs;


  Future startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500));
    animate.value = true;
    await Future.delayed(const Duration(milliseconds: 5000));
    Get.to( LoginScreen());
  }
}