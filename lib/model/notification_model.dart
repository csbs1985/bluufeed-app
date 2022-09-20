import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:universe_history_app/firestore/notifications_firestore.dart';
import 'package:universe_history_app/model/user_model.dart';
import 'package:universe_history_app/service/push_notification_service.dart';

class NotificationClass {
  final NotificatonFirestore _notificatonFirestore = NotificatonFirestore();

  Future<void> postNotification(BuildContext context, _form) async {
    try {
      await _notificatonFirestore.postNotification(_form);
    } on FirebaseAuthException catch (error) {
      debugPrint('ERROR => postNotification: ' + error.toString());
    }
  }

  setNotificationSendHistory(BuildContext context, _form) {
    var _body =
        'O usuário ${currentUser.value.first.name} compartilhou uma história com você. Clique aqui para ver.';
    var _title =
        '${currentUser.value.first.name} compartilhou uma história com você.';

    _sendNotification(
      context,
      _title,
      _body,
      _form['contentId'],
      _form['userId'],
    );
  }

  Future<void> _sendNotification(
    BuildContext context,
    String _title,
    String _body,
    String _contentId,
    String _user,
  ) async {
    await Provider.of<PushNotificationService>(context, listen: false)
        .sendNotification(
      _title,
      _body,
      _contentId,
      _user,
    );
  }
}

enum NotificationEnum {
  COMMENT_ANONYMOUS('comment_anonymous'),
  COMMENT_SIGNED('comment_signed'),
  SEND_HISTORY('send_history');

  final String value;
  const NotificationEnum(this.value);
}
