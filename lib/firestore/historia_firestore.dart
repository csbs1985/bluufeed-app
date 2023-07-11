import 'package:eight_app/class/usuario_class.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HistoriaFirestore {
  CollectionReference historias =
      FirebaseFirestore.instance.collection('historias');

  getAllHistoriaIdUsuario(String idUsuario) {
    return historias
        .orderBy('dataRegistro')
        .where('idUsuario', isEqualTo: idUsuario);
  }

  getHistoriaId(String _idHistoria) async {
    return await historias.where('idHistoria', isEqualTo: _idHistoria).get();
  }

  snapshotsHistoria(String _idHistoria) {
    return historias.where('idHistoria', isEqualTo: _idHistoria).snapshots();
  }

  deletarHistoriaId(String _idHistoria) {
    return historias.doc(_idHistoria).delete();
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

  postHistoria(Map<String, dynamic> _historia) {
    return historias.doc(_historia['idHistoria']).set(_historia);
  }
}
