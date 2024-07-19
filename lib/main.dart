import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:mortuary/core/styles/color_schemes.dart';
import 'package:mortuary/core/styles/text_theme.dart';
import 'package:mortuary/features/authentication/init_auth.dart';
import 'package:mortuary/features/splash/presentation/widget/splash_screen.dart';
import 'package:mortuary/init_core.dart';
import 'package:mortuary/init_main.dart';

import 'core/services/push_notification_sevice.dart';

 bool isUserLoggedIn = false;

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // await Firebase.initializeApp();
  debugPrint("background notification");
  PushNotifications().firebaseMessagingBackgroundHandler(message);
}

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
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
        theme: ThemeData(
          colorScheme: lightColorScheme,
          textTheme: lightTextTheme,
        ),
        home: const SplashScreen());
  }
}
