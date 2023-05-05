import 'package:bluufeed_app/class/usuario_class.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HistoriaFirestore {
  CollectionReference historias =
      FirebaseFirestore.instance.collection('historias');

  snapshotsHistoria(String _idHistory) {
    return historias.where('idHistoria', isEqualTo: _idHistory).snapshots();
  }

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

  pathQtdComentarioHistoria(Map<String, dynamic> _historia) {
    return historias
        .doc(_historia['idHistoria'])
        .update({'qtdComentario': _historia['qtdComentario']});
  }

  pathFavorito(Map<String, dynamic> _historia) {
    return historias
        .doc(_historia['id'])
        .update({'favoritos': _historia['favoritos']});
  }

  postHistoria(Map<String, dynamic> _historia) {
    return historias.doc(_historia['id']).set(_historia);
  }
}
