import 'package:cloud_firestore/cloud_firestore.dart';

class NotificacaoFirestore {
  CollectionReference notificacao =
      FirebaseFirestore.instance.collection('notificacao');

  getAllNotificacaoUser(String _idUsuario) {
    return notificacao
        .orderBy('dataNotificacao')
        .where('idDestinatario', isEqualTo: _idUsuario);
  }

  pathVizualizarNotificacao(String idNotificacao) {
    return notificacao.doc(idNotificacao).update({'isVisualizado': true});
  }

  postNotificacao(Map<String, dynamic> _notificacao) {
    return notificacao.doc(_notificacao['idNotificacao']).set(_notificacao);
  }
}
