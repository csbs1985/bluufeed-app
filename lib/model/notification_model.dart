import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:bluuffed_app/firestore/notifications_firestore.dart';
import 'package:bluuffed_app/model/history_model.dart';
import 'package:bluuffed_app/model/user_model.dart';
import 'package:bluuffed_app/service/push_notification_service.dart';

class NotificationClass {
  final NotificationFirestore _notificatonFirestore = NotificationFirestore();

  Future<void> postNotification(BuildContext context, _form) async {
    try {
      await _notificatonFirestore.postNotification(_form);
    } on FirebaseAuthException catch (error) {
      debugPrint('ERROR => postNotification: ' + error.toString());
    }
  }

  setNotificationSendHistory(BuildContext context, Map<String, dynamic> _form) {
    String _body =
        'O usuário ${currentUser.value.first.name} compartilhou uma história com você.';
    String _title = '${currentUser.value.first.name} mandou uma história';

    _sendNotification(
      context,
      _title,
      _body,
      _form['contentId'],
      _form['userId'],
    );
  }

  void setNotificationOnwer(
    BuildContext context,
    Map<String, dynamic> _form,
    bool _signed,
    String _comment,
  ) {
    String _title = _signed
        ? currentUser.value.first.name +
            ' fez um comentário na história em uma de suas histórias"'
        : ('Sua história "' +
            currentHistory.value.first.title +
            '" recebeu um comentário anônimo.');

    String _body = _signed
        ? currentUser.value.first.name + ': "' + _comment.trim() + '"'
        : '"' + _comment.trim() + '"';

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
