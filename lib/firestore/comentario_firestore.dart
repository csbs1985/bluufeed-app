import 'package:cloud_firestore/cloud_firestore.dart';

class ComentarioFirestore {
  CollectionReference comentarios =
      FirebaseFirestore.instance.collection('comentarios');

  getAllComentariosHistoria(String _idHistoria) {
    return comentarios
        .orderBy('dataRegistro')
        .where('idHistoria', isEqualTo: _idHistoria);
  }

  postComentario(Map<String, dynamic> _comentario) {
    return comentarios.doc(_comentario['idComentario']).set(_comentario);
  }
}
