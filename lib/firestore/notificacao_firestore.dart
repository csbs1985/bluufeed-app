import 'package:cloud_firestore/cloud_firestore.dart';

class NotificacaoFirestore {
  CollectionReference notificacao =
      FirebaseFirestore.instance.collection('notificacao');

  getAllNotificacaoUser(String _idUsuario) {
    return notificacao
        .orderBy('dataNotificacao')
        .where('idDestinatario', isEqualTo: _idUsuario);
  }

  pathNotificationView(String idNotificacao) {
    return notificacao.doc(idNotificacao).update({'isVisualizado': true});
  }

  postNotification(Map<String, dynamic> _notificacao) {
    return notificacao.doc(_notificacao['idNotificacao']).set(_notificacao);
  }
}
