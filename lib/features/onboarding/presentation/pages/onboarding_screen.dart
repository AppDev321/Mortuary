import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import Get package for navigation

import '../../../../core/constants/place_holders.dart';
import '../../../../core/styles/colors.dart';
import '../../../authentication/presentation/pages/login_screen.dart';
import '../../domain/entities/boarding_content.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            physics: const ClampingScrollPhysics(),
            controller: _controller,
            onPageChanged: (value) => setState(() => _currentPage = value),
            itemCount: contents.length,
            itemBuilder: (context, i) {
              var item = contents[i];
              return Stack(
                children: [
                  Image.asset(
                    item.image,
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.hexToColor("#3C3C3C").withOpacity(0.5),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                          border: Border.all(color: Colors.white, width: 1.0),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  contents.length,
                                      (int index) => buildDotIndicator(index),
                                ),
                              ),
                            ),
                            minPlaceHolder,
                            Text(
                              item.title,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              item.desc,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                fontWeight: FontWeight.w100,
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size.fromWidth(double.maxFinite),
                                backgroundColor: Theme.of(context).colorScheme.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              onPressed: () {
                                if (_currentPage == contents.length - 1) {
                                  // If last page is reached, navigate to login screen
                                  Get.offAll(() =>  LoginScreen(), predicate: (route) => route.isFirst);
                                } else {
                                  _controller.nextPage(
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.easeIn,
                                  );
                                }
                              },
                              child: Text(
                                item.buttonLabel,
                                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildDotIndicator(int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0),
      child: Container(
        height: 10,
        width: 10,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _currentPage == index ? AppColors.primaryColor : Colors.white,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the PageController
    super.dispose();
  }
}
