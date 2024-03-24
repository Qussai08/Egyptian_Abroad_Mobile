import 'package:egyptians_abroad/app/routes/app_pages.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'dart:convert';
import '../data/providers/auth_provider.dart';
import '../services/auth_service.dart';

class NotificationHelper {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  late final NotificationDetails _notificationDetails;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    await firebaseMessaging.setAutoInitEnabled(true);
    await firebaseMessaging.requestPermission();

    // print token
    String? fcmToken = await firebaseMessaging.getToken();
    // await getFcmToken();
    print('getToken FCMToken: $fcmToken');

////////////////////////////////////////////////////////////////////////////////////////////////////////////
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'android_notification', 'android_notification',
        importance: Importance.max);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(channel.id, channel.name,
            importance: Importance.max,
            priority: Priority.high,
            icon: 'app_icon');

    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails(
            presentAlert: true,
            presentSound: true,
            presentBadge: true,
            interruptionLevel: InterruptionLevel.critical);

    _notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);

////////////////////////////////////////////////////////////////////////////////////////////////////////////

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );

    // Handle incoming messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _handleMessage(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      Get.offAllNamed(Routes.BOTTOMNAVIGATION,
          arguments: [int.parse(message.data['NotificationId']), 1]);
      // }
    });
  }

  void _handleMessage(RemoteMessage message) {
    _showLocalNotification(message);
  }

  void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    // Open Notification Screen
    print('onDidReceiveNotificationResponse');

    Get.offAllNamed(Routes.BOTTOMNAVIGATION,
        arguments: [getNotificationId(notificationResponse), 1]);
  }

  int getNotificationId(NotificationResponse notificationResponse) {
    print("notificationResponse.payload ${notificationResponse.payload}");
    Map<String, dynamic> data = jsonDecode(notificationResponse.payload!);

    return int.parse(data['NotificationId']);
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
        _notificationDetails,
        payload: jsonEncode(message.data));
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
    final fcmToken = await firebaseMessaging.getToken() ?? '';
    final userId = authService.userID ?? "";

    await authProvider.registerFCMToken(fcmToken, userId).then((value) {
      if (value.body ?? false) {
        authService.setFCMToken(fcmToken);
      }
    }, onError: (err) {});

    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) async {
      await authProvider.registerFCMToken(fcmToken, userId).then((value) {
        if (value.body ?? false) {
          authService.setFCMToken(fcmToken);
        }
      }, onError: (err) {});
    }).onError((err) {
      print(err);
      print("onTokenRefresh -> registerFCMToken");
    });
    //   }
  }

  // Get token form firebase for android and ios
  // Future<String?> getFcmToken() async {
  //   if (GetPlatform.isAndroid) {
  //     return await firebaseMessaging.getToken();
  //   } else if (GetPlatform.isIOS) {
  //     return await firebaseMessaging.getAPNSToken();
  //   }
  //   return null;
  // }

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
