import 'dart:async';
import 'dart:convert';


import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'notification_service.dart';


class PushNotifications {
  static final PushNotifications _instance = PushNotifications._internal();

  factory PushNotifications() => _instance;

  PushNotifications._internal();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  final bool _isConfigured = false;

  final _tokenStreamController = StreamController<String>.broadcast();

  Stream<String> get token => _tokenStreamController.stream;

  final _notificationStreamController = StreamController<dynamic>.broadcast();

  Stream<dynamic> get notification => _notificationStreamController.stream;

  init() {
    // Request push permissions
    _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    // Get device token
    _firebaseMessaging.getToken().then((token) {
      debugPrint('===== FCM Token =====');
      debugPrint(token.toString());
      saveDeviceToken(token);
    });

    // Configure messaging receiving
    //if (!_isConfigured) {

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      debugPrint('======= On Message =======');
      setStreamData(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      debugPrint('======= On App Open Message =======');
      setStreamData(message);
    });

    // _isConfigured = true;
    //}
  }

  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    //   await Firebase.initializeApp();
    debugPrint('======= On Background Message =======');
    setStreamData(message, userStream: false);
  }

  setStreamData(RemoteMessage message, {bool userStream = true}) {
    debugPrint('Handling a foreground message: ${message.messageId}');
    debugPrint('Message data: ${message.data}');
    debugPrint('Message notification: ${message.notification?.title}');
    debugPrint('Message notification: ${message.notification?.body}');

    debugPrint('===== STREAM NOTIFICATION =====');

    if (userStream) {
      _notificationStreamController.sink.add(message);
    }
    var notificationBody = message.notification!.body.toString();
    try {
      var body = message.notification?.body;
      var json = jsonEncode(body);
      print(json);
       final data = NotificationBodyClass.fromJson(jsonDecode(body.toString()));
      //final data = DeathReportAlert.fromJson(jsonDecode(body.toString()));
      notificationBody = jsonEncode(data);
    } catch (e) {
      debugPrint('The provided string is not valid JSON');
    }

    NotificationService().newNotification(
        message.notification!.title.toString(), notificationBody,message.data.isEmpty ? null : jsonEncode(message.data), false);
  }

  saveDeviceToken(token) {
    // await UserPreferences.setString(config.deviceTokenPrefId, token);
    _tokenStreamController.sink.add(token);
  }

  /* Future<String> getDeviceToken() async {
    return await UserPreferences.getString(config.deviceTokenPrefId);
  }*/

  dispose() {
    _notificationStreamController.close();
    _tokenStreamController.close();
  }
}

class NotificationBodyClass {
  final String type;
  final String message;

  NotificationBodyClass(this.type, this.message);

  NotificationBodyClass.fromJson(Map<String, dynamic> json)
      : type = json['type'],
        message = json['message'];

  Map<String, dynamic> toJson() => {
    'type': type,
    'message': message,
  };
}