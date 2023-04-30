import 'package:bluufeed_app/class/historia_class.dart';
import 'package:bluufeed_app/class/usuario_class.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HistoriaFirestore {
  CollectionReference historias =
      FirebaseFirestore.instance.collection('historias');

  snapshotsHistoria(String _idHistory) {
    return historias.where('idHistoria', isEqualTo: _idHistory).snapshots();
  }

  //////////////////

  deleteHistory(String _idHistory) {
    return historias.doc(_idHistory).delete();
  }

  getAllHistoryUser() {
    return historias
        .orderBy('date')
        .where('userId', isEqualTo: currentUsuario.value.idUsuario)
        .get();
  }

  pathNameUserHistory(String _id) {
    return historias
        .doc(_id)
        .update({'userName': currentUsuario.value.nomeUsuario});
  }

  pathQtyCommentHistory(HistoriaModel _history) {
    return historias
        .doc(_history.idHistoria)
        .update({'qtdComentario': _history.qtdComentario});
  }

  pathFavorito(Map<String, dynamic> _history) {
    return historias
        .doc(_history['id'])
        .update({'favoritos': _history['favoritos']});
  }

  postHistory(Map<String, dynamic> _history) {
    return historias.doc(_history['id']).set(_history);
  }
}
