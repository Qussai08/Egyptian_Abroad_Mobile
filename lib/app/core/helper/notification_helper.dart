// import 'dart:math';
import 'package:egyptians_abroad/app/routes/app_pages.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../data/providers/auth_provider.dart';
import '../services/auth_service.dart';

class NotificationHelper {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    await firebaseMessaging.setAutoInitEnabled(true);
    await firebaseMessaging.requestPermission();

    // print token
    String? fcmToken = await getFcmToken();
    print('FCMToken: $fcmToken');

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);

    // Handle incoming messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _handleMessage(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Open Notification Screen
      Get.toNamed(Routes.NOTIFICATIONS);
    });
  }

  void _handleMessage(RemoteMessage message) {
    _showLocalNotification(message);
  }

  void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    // Open Notification Screen
    Get.toNamed(Routes.NOTIFICATIONS);
  }

  Future<void> _showLocalNotification(RemoteMessage message) async {
    var androidDetails = const AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
    );
    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails(threadIdentifier: 'thread_id');
    var generalNotificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      message.notification?.title, // Notification Title
      message.notification?.body, // Notification Body
      generalNotificationDetails,
    );
  }

  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage = await firebaseMessaging.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }
  }

  Future<void> registerFCMToken() async {
    AuthService authService = Get.find();
    AuthProvider authProvider = Get.find();
    final fcmToken = await getFcmToken() ?? '';
    if ((authService.fcmToken?.isEmpty ?? true) ||
        authService.fcmToken != fcmToken) {
      await authProvider.registerFCMToken(fcmToken).then((value) {
        if (value.body ?? false) {
          authService.setFCMToken(fcmToken);
        }
      }, onError: (err) {});
    }
    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) async {
      await authProvider.registerFCMToken(fcmToken).then((value) {
        if (value.body ?? false) {
          authService.setFCMToken(fcmToken);
        }
      }, onError: (err) {});
    }).onError((err) {
      // print(err);
    });
  }

  // Get token form firebase for android and ios
  Future<String?> getFcmToken() async {
    if (GetPlatform.isAndroid) {
      return await firebaseMessaging.getToken();
    } else if (GetPlatform.isIOS) {
      return await firebaseMessaging.getAPNSToken();
    }
    return null;
  }

// Subscribe to topic
  Future<void> subscribeToTopic(String topic) async {
    await firebaseMessaging.subscribeToTopic(topic);
  }

  // Unsubscribe from topic
  Future<void> unSubscribeFromTopic(String topic) async {
    await firebaseMessaging.unsubscribeFromTopic(topic);
  }

// Delete token
  Future<void> deleteFCMToken() async {
    await firebaseMessaging.deleteToken();
  }
}
