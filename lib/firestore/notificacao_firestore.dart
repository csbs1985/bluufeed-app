import 'package:cloud_firestore/cloud_firestore.dart';

class NotificacaoFirestore {
  CollectionReference notificacoes =
      FirebaseFirestore.instance.collection('notificacoes');

  getAllNotificacaoUser(String _idUsuario) {
    return notificacoes
        .orderBy('dataRegistro')
        .where('idDestinatario', isEqualTo: _idUsuario);
  }

  pathVizualizarNotificacao(String idNotificacao) {
    return notificacoes.doc(idNotificacao).update({'isVisualizado': true});
  }

  postNotificacao(Map<String, dynamic> _notificacao) {
    return notificacoes.doc(_notificacao['idNotificacao']).set(_notificacao);
  }
}
