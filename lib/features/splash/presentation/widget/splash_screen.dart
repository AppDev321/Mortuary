import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mortuary/core/constants/app_assets.dart';
import 'package:mortuary/core/constants/place_holders.dart';
import 'package:mortuary/core/styles/colors.dart';
import 'package:mortuary/core/widgets/custom_text_widget.dart';
import 'package:mortuary/features/splash/presentation/get/splash_controller.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/animated_widget.dart';
class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  final splashController = Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    SplashScreenController.find.startAnimation();

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
            child: CustomAnimatedWidget(
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
          ),
        ],
      ),
    );
  }
}
