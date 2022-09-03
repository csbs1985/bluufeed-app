import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:universe_history_app/firestore/users_firestore.dart';
import 'package:universe_history_app/model/user_model.dart';
import 'package:universe_history_app/service/local_notification_service.dart';
import 'package:http/http.dart' as http;

ValueNotifier<bool> currentNotification = ValueNotifier<bool>(false);

class PushNotificationService {
  final LocalNotificationService _notificationService;
  final UsersFirestore _usersFirestore = UsersFirestore();

  PushNotificationService(this._notificationService);

  Future<void> initialize() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      badge: true,
      sound: true,
      alert: true,
    );

    _onMessage();
    _onMessageOpenedApp();
  }

  _onMessage() {
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (currentUser.value.first.isNotification) {
        if (notification != null && android != null) {
          currentNotification.value = true;
          _notificationService.showNotification(CustomNotification(
            id: android.hashCode,
            title: notification.title!,
            body: notification.body!,
            payload: message.data['id'] ?? '',
          ));
        }

        // TODO: ios
      }
    });
  }

  _onMessageOpenedApp() {
    FirebaseMessaging.onMessageOpenedApp.listen(_goToPageAfterMessage);
  }

  _goToPageAfterMessage(message) {
    final String route = message.data['payload'].isNotEmpty ?? '';
    navService.pushNamed('/history', args: message.data[route]);
  }

  Future<void> sendNotification(
      String title, String body, String idHistory, String user) async {
    await _usersFirestore.getTokenOwner(user).then((result) async {
      try {
        await http.post(
          Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization':
                'key=AAAAUIaHHec:APA91bGzC9qta9DjF9Z-p16uFv49mfM8uXFo7g7V9EN3rr7wjyvYl9-JSG1m2myxavNpuOjNzbII8lkZjCVYQ9YiaeIctT9Kr0tekihzXeDVWtVtxmy4Y1pqAGIMSEuH7rKOLPAtiZku',
          },
          body: jsonEncode(
            {
              "to": result.docs.first['token'],
              'priority': 'high',
              'notification': {
                'title': title,
                'body': body,
                'click_action': 'FLUTTER_NOTIFICATION_COMMENT',
                'android': '',
                'ios': '',
              },
              'data': {
                'id': idHistory,
              },
              "android": {
                "direct_boot_ok": true,
              },
            },
          ),
        );
      } catch (error) {
        debugPrint("ERROR:$error");
      }
    }).catchError((error) => debugPrint('ERROR:$error'));
  }
}
