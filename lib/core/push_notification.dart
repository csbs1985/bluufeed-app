// ignore_for_file: curly_braces_in_flow_control_structures, avoid_print

import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:universe_history_app/core/api.dart';
import 'package:universe_history_app/core/variables.dart';
import 'package:http/http.dart' as http;
import 'package:universe_history_app/shared/models/owner_model.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notifications',
  importance: Importance.high,
  playSound: true,
  enableVibration: true,
);

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class PushNotification {
  final Api api = Api();
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  late String _tokenOwner = currentOwner.value.first.token;

  init() {
    _requestPermission();
    _loadFCM();
    _onMessage();
  }

  void _requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized)
      print('Usuário concedeu permissão.');
    else if (settings.authorizationStatus == AuthorizationStatus.provisional)
      print('Usuário concedeu permissão provisória.');
    else
      print('Usuário não deu permissão ou ignorou a solicitação.');
  }

  void _loadFCM() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);
  }

  void _onMessage() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                playSound: true,
                importance: Importance.high,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });
  }

  void getToken() async {
    await api.getToken().then((_token) async {
      await api
          .setToken(_token)
          .then((_result) => currentToken.value = _result);
    }).catchError((error) => print('ERROR:' + error.toString()));
  }

  void sendNotificationComment(String title, String body) async {
    await api
        .getTokenOwner()
        .then((result) => _tokenOwner = result.docs.first['token'])
        .catchError((error) => print('ERROR:' + error.toString()));

    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAUIaHHec:APA91bGzC9qta9DjF9Z-p16uFv49mfM8uXFo7g7V9EN3rr7wjyvYl9-JSG1m2myxavNpuOjNzbII8lkZjCVYQ9YiaeIctT9Kr0tekihzXeDVWtVtxmy4Y1pqAGIMSEuH7rKOLPAtiZku',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{'body': body, 'title': title},
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_COMMENT',
              'id': '1',
              'status': 'done'
            },
            "to": _tokenOwner,
          },
        ),
      );
    } catch (error) {
      print("ERROR:" + error.toString());
    }
  }
}
