import 'package:ecomerce_app/core/core.dart';
import 'package:ecomerce_app/features/feature.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

import 'package:get/get.dart';

class NotificationController extends GetxController {
  final FlutterLocalNotificationsPlugin notificationPlugin =
      FlutterLocalNotificationsPlugin();

  bool isInitialized = false;

  @override
  void onInit() {
    super.onInit();
    initNotification();
  }

  // INITIALIZE
  Future<void> initNotification() async {
    if (isInitialized) return; // Prevent re-initialization
    _configureLocalTimezone();
    // Android init settings
    const initSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS init settings
    const initSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    // Init settings
    const initSetting = InitializationSettings(
      android: initSettingsAndroid,
      iOS: initSettingsIOS,
    );

    await notificationPlugin.initialize(
      initSetting,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );
    isInitialized = true;
  }

  void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('Notification Payload: $payload');
    } else {
      debugPrint('Notification Done');
    }
    Get.toNamed(
      RouteHelper.notifiedPage,
      arguments: {
        'label': notificationResponse.payload,
      },
    );
  }

  // NOTIFICATION DETAILS
  NotificationDetails notificationDetails() {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'daily_channel_id',
      'Daily Notification',
      channelDescription: 'Daily Notification Channel',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails();

    return const NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
  }

  // SHOW NOTIFICATION
  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
  }) async {
    await notificationPlugin.show(
      id,
      title,
      body,
      notificationDetails(),
      payload: 'Default_sound',
    );
  }

  Future<void> scheduledNotification(
    int hour,
    int minute,
    TaskModel taskModel,
  ) async {
    await notificationPlugin.zonedSchedule(
        taskModel.id!,
        taskModel.title,
        taskModel.note,
        _convertTime(hour, minute),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'channelId',
            'channelNam',
            channelDescription: 'channelDescription',
          ),
        ),
        // androidScheduleMode: AndroidScheduleMode.alarmClock,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: "${taskModel.title}|" "${taskModel.note}|");
  }

  tz.TZDateTime _convertTime(int hour, int minute) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
    if (scheduleDate.isBefore(now)) {
      scheduleDate = scheduleDate.add(Duration(days: 1));
    }
    return scheduleDate;
  }

  Future<void> _configureLocalTimezone() async {
    tz.initializeTimeZones();
    final String timezone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timezone));
  }
}