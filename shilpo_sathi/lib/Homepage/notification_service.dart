import 'dart:ui';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initSettings =
    InitializationSettings(android: androidSettings);

    await _notificationsPlugin.initialize(initSettings);
  }

  static Future<void> showNotification({
    required String title,
    required String body,
    int id = 0,
  }) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'login_channel_id',
      'Login Notifications',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidDetails);

    await _notificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails,
    );
  }
}
