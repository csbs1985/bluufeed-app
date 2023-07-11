import 'package:eight_app/class/usuario_class.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ComentarioFirestore {
  CollectionReference comentarios =
      FirebaseFirestore.instance.collection('comentarios');

  getAllComentariosHistoria(String _idHistoria) {
    return comentarios
        .orderBy('dataRegistro')
        .where('idHistoria', isEqualTo: _idHistoria);
  }

  getTodosComentarioUsuario(String _idHistoria) {
    return comentarios
        .orderBy('dataRegistro')
        .where('idHistoria', isEqualTo: _idHistoria)
        .get();
  }

  postComentario(Map<String, dynamic> _comentario) {
    return comentarios.doc(_comentario['idComentario']).set(_comentario);
  }

  upStatusUserComment(String _idHistoria) {
    return comentarios
        .doc(_idHistoria)
        .update({'userStatus': SituacaoUsuarioEnum.DELETADO.value});
  }
}
