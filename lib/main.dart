import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:mortuary/core/styles/color_schemes.dart';
import 'package:mortuary/core/styles/text_theme.dart';
import 'package:mortuary/features/authentication/init_auth.dart';
import 'package:mortuary/features/onboarding/presentation/pages/onboarding_screen.dart';
import 'package:mortuary/features/splash/presentation/widget/splash_screen.dart';
import 'package:mortuary/init_core.dart';
import 'package:mortuary/init_main.dart';

import 'features/death_report/presentation/widget/report_death_screen.dart';


void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  FlutterNativeSplash.remove();
  initCore();
  initMain();
  await initAuth();
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: Get.key,
      debugShowCheckedModeBanner: false,
      theme:  ThemeData(
        colorScheme: lightColorScheme,
        textTheme: lightTextTheme,
      ),
      home:  ReportDeathScreen()
    );
  }
}

