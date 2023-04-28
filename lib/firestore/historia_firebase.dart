import 'package:bluufeed_app/class/historia_class.dart';
import 'package:bluufeed_app/class/usuario_class.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HistoriaFirestore {
  //TODO: remomear "stoties" para "historias"

  CollectionReference historias =
      FirebaseFirestore.instance.collection('historias');

  deleteHistory(String _idHistory) {
    return historias.doc(_idHistory).delete();
  }

  getAllHistoryUser() {
    return historias
        .orderBy('date')
        .where('userId', isEqualTo: currentUsuario.value.idUsuario)
        .get();
  }

  snapshotsHistory(String _idHistory) {
    return historias.where('id', isEqualTo: _idHistory).snapshots();
  }

  getHistory(String _idHistory) {
    return historias.where('id', isEqualTo: _idHistory).get();
  }

  pathNameUserHistory(String _id) {
    return historias.doc(_id).update({'userName': currentUsuario.value.nome});
  }

  pathQtyCommentHistory(HistoriaModel _history) {
    return historias
        .doc(_history.idHistoria)
        .update({'qtyComment': _history.qtdComentario});
  }

  pathFavorito(Map<String, dynamic> _history) {
    return historias
        .doc(_history['id'])
        .update({'bookmarks': _history['bookmarks']});
  }

  postHistory(Map<String, dynamic> _history) {
    return historias.doc(_history['id']).set(_history);
  }
}
