import 'package:bluufeed_app/class/usuario_class.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HistoriaFirestore {
  CollectionReference historias =
      FirebaseFirestore.instance.collection('historias');

  getAllHistoriaIdUsuario(String idUsuario) {
    return historias
        .orderBy('dataRegistro')
        .where('idUsuario', isEqualTo: idUsuario);
  }

  snapshotsHistoria(String _idHistory) {
    return historias.where('idHistoria', isEqualTo: _idHistory).snapshots();
  }

  deletarHistoriaId(String _idHistory) {
    return historias.doc(_idHistory).delete();
  }

  pathTodosUsuarioHistoria() {
    return historias.where('idUsuario',
        isEqualTo: currentUsuario.value.idUsuario);
  }

  pathNameUserHistory(String _id) {
    return historias
        .doc(_id)
        .update({'nomeUsuario': currentUsuario.value.nomeUsuario});
  }

  pathQtdComentarioHistoria(Map<String, dynamic> _historia) {
    return historias
        .doc(_historia['idHistoria'])
        .update({'qtdComentario': _historia['qtdComentario']});
  }

  pathFavorito(Map<String, dynamic> _historia) {
    return historias
        .doc(_historia['idHistoria'])
        .update({'favoritos': _historia['favoritos']});
  }

  postHistoria(Map<String, dynamic> _historia) {
    return historias.doc(_historia['idHistoria']).set(_historia);
  }
}
