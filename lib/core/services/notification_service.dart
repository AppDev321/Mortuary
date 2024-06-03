import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:mortuary/core/enums/enums.dart';
import 'package:mortuary/features/authentication/domain/enities/user_model.dart';
import 'package:mortuary/features/death_report/domain/enities/death_report_alert.dart';
import 'package:mortuary/features/death_report/presentation/widget/transport/accept_report_death_screen.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';

import '../../features/authentication/presentation/get/auth_controller.dart';
import '../../main.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();

  factory NotificationService() => _instance;

  late FlutterLocalNotificationsPlugin plugin;


  NotificationService._internal() {
    tz.initializeTimeZones();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
          requestSoundPermission: false,
          requestBadgePermission: false,
          requestAlertPermission: false,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );


    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    plugin = FlutterLocalNotificationsPlugin();
    plugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
  }
  int notificationID = 0;

  void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      print('notification payload: $payload');

      if (isUserLoggedIn) {
        final AuthController authController = Get.find();
        if (authController.session != null &&
            authController.session!.userRoleType == UserRole.transport) {
            Map<String, dynamic> payloadMap = json.decode(payload.toString());
            var deathAlert = DeathReportAlert.fromJson(payloadMap);
            Get.to(() => AcceptDeathAlertScreen(dataModel: deathAlert, userRole: UserRole.transport, onReportHistoryButton: () {}));
          }
      }
    }
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {}

  Future<void> newNotification(String title,String msg,String? payload, bool vibration,{bool sound =true}) async {
    // Define vibration pattern
    var vibrationPattern = Int64List(4);
    vibrationPattern[0] = 0;
    vibrationPattern[1] = 1000;
    vibrationPattern[2] = 5000;
    vibrationPattern[3] = 2000;

    AndroidNotificationDetails androidNotificationDetails;

    const channelName = 'Text messages';

    androidNotificationDetails = AndroidNotificationDetails(

        channelName, channelName,
        importance: Importance.max,
        playSound: sound,
        priority: Priority.high,
        vibrationPattern: vibration ? vibrationPattern : null,
        enableVibration: vibration);

    var iosNotificationDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentSound: sound,
      presentBadge: true,
      categoryIdentifier: channelName
    );

    var notificationDetails = NotificationDetails(
        android: androidNotificationDetails,iOS: iosNotificationDetails);

    try {
      await plugin.show(notificationID++, title, msg, notificationDetails,payload:payload );
    } catch (ex) {
      print("notificaiton exception ==>"+ex.toString());
    }
  }



  Future<void> scheduledNotification(String title,String msg, bool vibration,{bool sound =true}) async {
    // Define vibration pattern
    var vibrationPattern = Int64List(4);
    vibrationPattern[0] = 0;
    vibrationPattern[1] = 1000;
    vibrationPattern[2] = 5000;
    vibrationPattern[3] = 2000;

    AndroidNotificationDetails androidNotificationDetails;

    final channelName = 'Text messages';

    androidNotificationDetails = AndroidNotificationDetails(

        channelName, channelName,
        importance: Importance.max,
        playSound: sound,
        priority: Priority.high,
        vibrationPattern: vibration ? vibrationPattern : null,
        enableVibration: vibration);

    var iosNotificationDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentSound: sound,
        presentBadge: true,
        categoryIdentifier: channelName
    );

    var notificationDetails = NotificationDetails(
        android: androidNotificationDetails,iOS: iosNotificationDetails);

    try {
      await plugin.zonedSchedule(
          notificationID++,
          title,
          msg,
          tz.TZDateTime.now(tz.local).add(const Duration(seconds: 30)),
          notificationDetails,
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
          matchDateTimeComponents: DateTimeComponents.dateAndTime);

    } catch (ex) {
      print("notificaiton exception ==>"+ex.toString());
    }
  }



  Future<void> periodicallyNotification(String title,String msg, bool vibration,{bool sound =true}) async {
    // Define vibration pattern
    var vibrationPattern = Int64List(4);
    vibrationPattern[0] = 0;
    vibrationPattern[1] = 1000;
    vibrationPattern[2] = 5000;
    vibrationPattern[3] = 2000;

    AndroidNotificationDetails androidNotificationDetails;

    final channelName = 'Text messages';

    androidNotificationDetails = AndroidNotificationDetails(

        channelName, channelName,
        importance: Importance.max,
        playSound: sound,
        priority: Priority.high,
        vibrationPattern: vibration ? vibrationPattern : null,
        enableVibration: vibration);

    var iosNotificationDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentSound: sound,
        presentBadge: true,
        categoryIdentifier: channelName
    );

    var notificationDetails = NotificationDetails(
        android: androidNotificationDetails,iOS: iosNotificationDetails);

    try {
      await plugin.periodicallyShow(
        notificationID++,
          title,
          msg,
          RepeatInterval.hourly,
          notificationDetails,
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
       );

    } catch (ex) {
      print("notificaiton exception ==>"+ex.toString());
    }
  }


  Future<void> scheduleDailyNotification(bool vibration,{bool sound =true, int id = 0, String? hourAndMinute /*Like 10:30*/, String? title, String? body,String? payload}) async {
    // Define vibration pattern
    var vibrationPattern = Int64List(4);
    vibrationPattern[0] = 0;
    vibrationPattern[1] = 1000;
    vibrationPattern[2] = 5000;
    vibrationPattern[3] = 2000;

    AndroidNotificationDetails androidNotificationDetails;

    final channelName = 'Text messages';

    androidNotificationDetails = AndroidNotificationDetails(

        channelName, channelName,
        importance: Importance.max,
        playSound: sound,
        priority: Priority.high,
        vibrationPattern: vibration ? vibrationPattern : null,
        enableVibration: vibration);

    var iosNotificationDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentSound: sound,
        presentBadge: true,
        categoryIdentifier: channelName
    );

    var notificationDetails = NotificationDetails(
        android: androidNotificationDetails,iOS: iosNotificationDetails);

    final String? timeZoneName = await FlutterTimezone.getLocalTimezone();
    debugPrint("timeZoneName=$timeZoneName");
    tz.setLocalLocation(tz.getLocation(timeZoneName!));

    int? hour = int.tryParse(hourAndMinute!.substring(0, 2));
    int? minute = int.tryParse(hourAndMinute!.substring(3, 5));
    if(hour == null || minute == null){
      debugPrint("Cannot parse $hourAndMinute. Not sch");
      return;
    }

    tz.TZDateTime nextTimeToRun = _nextInstanceOfTimeOfDay(hour, minute);
    debugPrint("starting daily time zone schedule: id=$id title=$title body=$body $nextTimeToRun");
    await plugin.zonedSchedule(
        minute*2,
        title,
        body,
        nextTimeToRun,
        notificationDetails,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
    debugPrint("completed daily time zone schedule at $hourAndMinute with title $title");
  }

  tz.TZDateTime _nextInstanceOfTimeOfDay(int hour, int minute) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  Future<void> scheduleDailyNotifications({List<String>? hourAndMinuteList /*Like 10:30*/, String? title, String? body, String? payload }) async {
    debugPrint("Scheduling daily notifications for $hourAndMinuteList");
    _cancelAllNotifications();
    hourAndMinuteList?.forEach((hourAndMinute) {
      scheduleDailyNotification(false,
          hourAndMinute: hourAndMinute, title: "$title -- $hourAndMinute", body: body, payload: payload);
    });
  }



  Future<void> _cancelNotification(int id) async {
    await plugin.cancel(--id);
  }

  Future<void> _cancelNotificationWithTag(int id, tag) async {
    await plugin.cancel(--id, tag: tag);
  }

  Future<void> _cancelAllNotifications() async {
    debugPrint('Cancelling all notifications');
    await plugin.cancelAll();
    debugPrint('Cancelled all notifications');
  }
}
