import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mortuary/core/constants/app_assets.dart';
import 'package:mortuary/core/constants/place_holders.dart';
import 'package:mortuary/core/styles/colors.dart';
import 'package:mortuary/core/widgets/custom_text_widget.dart';
import 'package:mortuary/features/authentication/presentation/pages/login_screen.dart';
import 'package:mortuary/features/splash/presentation/get/splash_controller.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/animated_widget.dart';
import '../../builder_ids.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {

  late AnimationController scaleController;
  late Animation<double> scaleAnimation;


  @override
  void initState() {
    super.initState();
    SplashScreenController controller = Get.find();
    scaleController =
    AnimationController(vsync: this, duration: const Duration(milliseconds: 500))
      ..addStatusListener(
            (status) {
          if (status == AnimationStatus.completed) {
            Get.off(LoginScreen());
          }
        },
      );

    scaleAnimation =
        Tween<double>(begin: 0.0, end: Get.height).animate(scaleController);

    controller.startAnimation(scaleController);
  }


  @override
  void dispose() {
    scaleController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return GetBuilder<SplashScreenController>(
      id:updatedSplash,
      builder: (controller) {
        return Scaffold(
          body: Stack( // Wrap the Column with Stack
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: AppColors.appBackgroundColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    CustomAnimatedWidget(
                      animation: AnimationType.SLIDE_FROM_TOP,
                      delayDuration: const Duration(milliseconds: 500),
                      animationDuration: const Duration(seconds: 3),
                      child: SvgPicture.asset(AppAssets.icSplashLogo),
                    ),
                    sizeFieldLargePlaceHolder,
                    CustomAnimatedWidget(
                      animation: AnimationType.SLIDE_FROM_BOTTOM,
                      delayDuration: const Duration(milliseconds: 500),
                      animationDuration: const Duration(seconds: 3),
                      child:  CustomTextWidget(
                        text: AppStrings.splashTitle1.toUpperCase(),
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.w900,
                        size: 30,
                      ),
                    ),
                    // Remove Expanded widget from here
                  ],
                ),
              ),

              Positioned( // Position the Expanded widget
                bottom: 80,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    CustomAnimatedWidget(
                      animation: AnimationType.SLIDE_FROM_BOTTOM,
                      delayDuration: const Duration(milliseconds: 500),
                      animationDuration: const Duration(seconds: 3),
                      child:  CustomTextWidget(
                        text: AppStrings.splashTitle2.toUpperCase(),
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.w900,
                        size: 15,
                      ),
                    ),
                    sizeFieldMediumPlaceHolder,
                    controller.isApiLoading
                          ? const Center(
                             child: CircularProgressIndicator(),
                           )
                          : Container()
                    ],
                ),
              ),
              Positioned(
                top: Get.height/2,
                left: Get.width/2,
                child: AnimatedBuilder(
                  animation: scaleAnimation,
                  builder: (c, child) => Transform.scale(
                    scale: scaleAnimation.value,
                    child: Container(
                      height: 1,
                      width: 1,
                      decoration:  BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green.shade50,
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),
        );
      }
    );
  }
}
