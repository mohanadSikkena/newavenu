
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:newavenue/shared/network/local/cache_helper.dart';


class FirebaseNotifications {


  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;
  static String? _fcm;
  static Future<String?> getFCM() async {
    _fcm = await _firebaseMessaging.getToken();
    await CacheHelper.setFcmToken(_fcm);
    return _fcm;
  }

  showNotification(RemoteNotification? msg) async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
    AndroidInitializationSettings initializationSettingsAndroid = const AndroidInitializationSettings("@mipmap/ic_launcher_foreground");
    DarwinInitializationSettings initializationSettingsIOS = const DarwinInitializationSettings();
    InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'com.example.newavenue',
      'newavenue',
      importance: Importance.max,
    );
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    AndroidNotificationDetails androidPlatformChannelSpecifics =
    const AndroidNotificationDetails(

      'com.example.newavenue',
      'newavenue',
      playSound: true,
      enableVibration: true,
      importance: Importance.max,
      priority: Priority.max,

    );
    DarwinNotificationDetails iOSPlatformChannelSpecifics =
    const DarwinNotificationDetails(
    );
    NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        40, msg!.title, msg.body, platformChannelSpecifics,
        payload: null);
  }

  void showMyNotification(RemoteMessage? m) {
    showNotification(m!.notification);
  }
}