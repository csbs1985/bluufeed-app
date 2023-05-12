import 'package:cloud_firestore/cloud_firestore.dart';

class NotificacaoFirestore {
  CollectionReference notificacao =
      FirebaseFirestore.instance.collection('notificacao');

  pathNotificationView(String idNotificacao) {
    return notificacao.doc(idNotificacao).update({'isVisualizado': true});
  }

  postNotification(Map<String, dynamic> _notificacao) {
    return notificacao.doc(_notificacao['idNotificacao']).set(_notificacao);
  }
}
