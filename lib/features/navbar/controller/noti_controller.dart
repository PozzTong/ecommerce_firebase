import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  final FlutterLocalNotificationsPlugin notificationPlugin =
      FlutterLocalNotificationsPlugin();

  RxBool isInitialized = false.obs;

  @override
  void onInit() {
    super.onInit();
    initNotification();
  }

  // INITIALIZE
  Future<void> initNotification() async {
    if (isInitialized.value) return; // Prevent re-initialization

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

    await notificationPlugin.initialize(initSetting);
    isInitialized.value = true;
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
    );
  }
}
