import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/state_manager.dart';
import 'package:mortuary/core/services/push_notification_sevice.dart';



class FCMController extends GetxController {

  var fcmToken = "".obs;
  var notification = RemoteMessage().obs;


  @override
  void onInit() async{
    // TODO: implement onInit
    super.onInit();
    PushNotifications().init();
    PushNotifications().token.listen((token) {
      fcmToken.value = token;
      debugPrint("FCM Token received");
    });

    PushNotifications().notification.listen(( message) {
      var data =  message as RemoteMessage;
      notification.value = data;
      debugPrint("FCM Notification Received from GetX controller");
    });


  }

  @override
  void onClose() {
    PushNotifications().dispose();
    super.onClose();
  }
  @override
  void dispose() {
    PushNotifications().dispose();
    super.dispose();
  }

}