import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// ignore: avoid_classes_with_only_static_members
class CustomNotification {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future onSelectNotification(
    String? payload,
  ) async {}

  static Future<void> initialize() async {
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    const initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {
        onSelectNotification(notificationResponse.payload);
      },
    );
  }

  static Future show(RemoteMessage message) async {
    if (Platform.isAndroid) {
      const channelId = 'high_importance_channel';
      const channelName = 'ETugal';
      // const channelDescription = 'to be use of customer';

      const platformChannelSpecifics = NotificationDetails(
        android: AndroidNotificationDetails(
          channelId,
          channelName,
          // channelDescription,
          importance: Importance.max,
          priority: Priority.high,
        ),
      );

      final notification = message.notification;
      await flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification!.title,
        notification.body,
        platformChannelSpecifics,
        payload: "",
      );
    }
  }
}
