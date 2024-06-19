import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lifeskillsapp/main.dart';
import '../screens/DetailsScreen.dart';
import '../screens/CustomScreen.dart';

class NotificationService {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  String? get payload => null;
  BuildContext? get context => null;

  Future<void> initialize() async {
    // Request permissions for iOS
    NotificationSettings settings = await firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        _showNotification(message);
      });
    }

    // Initialize local notifications
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // تم تحديث هذا الجزء ليتوافق مع الإصدار الأحدث من حزمة flutter_local_notifications
    DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );
    // تعريف معالج الرسائل في الخلفية
    FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);

    /* final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS, // تم تغيير الاسم هنا
    );  

    // تهيئة الإشعارات المحلية
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      // استخدام onDidReceiveNotificationResponse بدلاً من onSelectNotification
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        // قم بكتابة منطق الإشعار هنا
      }, // تأكد من تعريف هذه الدالة في فئتك
    );*/
  }

  Future<void> init() async {
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        // اكتب منطق الإشعار هنا
      },
    );
  }

  Future<void> _showNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('default_channel_id', 'Default Channel',
            channelDescription:
                'This is the default channel for notifications.',
            importance: Importance.max,
            priority: Priority.high,
            showWhen: false);

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title ?? 'Default Title',
      message.notification?.body ?? 'Default Body',
      platformChannelSpecifics,
      payload: message.data['payload'],
    );
  }

  Future<void> onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // فتح شاشة التفاصيل عند استقبال إشعار
    Navigator.of(context!).push(MaterialPageRoute(
        builder: (_) => DetailsScreen(
              title: title ?? 'Default Title',
              body: body ?? 'Default Body',
            )));
  }

  Future<void> onSelectNotification(payload) async {
    // استخدام المفتاح العالمي للوصول إلى context
    final context = navigatorKey.currentState?.context;

    if (context != null) {
      // فتح شاشة مخصصة عند اختيار إشعار
      Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => CustomScreen(
          payload: payload ?? 'Default Payload',
        ),
      ));
    }
  }
}

// تعريف دالة معالجة الرسائل في الخلفية خارج فئة NotificationService
Future<void> _backgroundMessageHandler(RemoteMessage message) async {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  // Show notification when receiving a background message
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'default_channel_id',
    'Default Channel',
    channelDescription: 'This is the default channel for notifications.',
    importance: Importance.max,
    priority: Priority.high,
  );

  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    message.hashCode,
    message.notification?.title ?? 'Default Title',
    message.notification?.body ?? 'Default Body',
    platformChannelSpecifics,
    payload: message.data['payload'],
  );
}
