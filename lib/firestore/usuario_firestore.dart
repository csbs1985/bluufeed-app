import 'package:bluufeed_app/class/usuario_class.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UsuarioFirestore {
  CollectionReference usuarios =
      FirebaseFirestore.instance.collection('usuarios');

  getNomeUsuario(String nomeUsuario) {
    return usuarios.where('nomeUsuario', isEqualTo: nomeUsuario).get();
  }

  getUsuarioEmail(String email) {
    return usuarios.where('email', isEqualTo: email).get();
  }

  getUsuarioId(String idUsuario) {
    return usuarios.where('idUsuario', isEqualTo: idUsuario).get();
  }

  getAllSeguindo(String idUsuario) {
    return usuarios
        .orderBy('nomeUsuario')
        .where('idUsuario', isEqualTo: idUsuario);
  }

  pathTodosUsuarioComentario() {
    return usuarios.where('idUsuario',
        isEqualTo: currentUsuario.value.idUsuario);
  }

  pathQtdFavoritos(UsuarioModel _usuario) {
    return usuarios
        .doc(_usuario.idUsuario)
        .update({'qtyBookmark': _usuario.qtdFavoritos});
  }

  pathQtdHistoriasUsuario(UsuarioModel _usuario) async {
    await usuarios
        .doc(_usuario.idUsuario)
        .update({"qtyHistory": _usuario.qtdHistorias});
  }

  pathSeguindo(List<String> _seguindo) {
    return usuarios
        .doc(currentUsuario.value.idUsuario)
        .update({'seguindo': _seguindo});
  }

  pathNotificacao() {
    return usuarios
        .doc(currentUsuario.value.idUsuario)
        .update({'isNotificacao': currentUsuario.value.isNotificacao});
  }

  pathPerfil(String nomeUsuario, String biografia, String dataAtualizacaoNome) {
    return usuarios.doc(currentUsuario.value.idUsuario).update({
      'biografia': biografia,
      'nomeUsuario': nomeUsuario,
      'dataAtualizacaoNome': dataAtualizacaoNome,
    });
  }

  postUsuario(Map<String, dynamic> _usuario) {
    return usuarios.doc(_usuario['idUsuario']).set(_usuario);
  }

  snapshotsUsuario(String _idUsuario) {
    return usuarios.where('idUsuario', isEqualTo: _idUsuario).snapshots();
  }

  // deleteUser() {
  //   return user.doc(currentUsuario.value.id).delete();
  // }

  // getTokenOwner(String user) {
  //   return user.where('id', isEqualTo: user).get();
  // }

  // getUserId(String? id) {
  //   return user.where('id', isEqualTo: id).get();
  // }

  // snapshotsUserId(String id) {
  //   return user.where('id', isEqualTo: id).snapshots();
  // }

  // pathBio(String bio) {
  //   return user.doc(currentUsuario.value.id).update({'bio': bio});
  // }

  // pathFallowing(List<dynamic> following) {
  //   return user.doc(currentUsuario.value.id).update({'following': following});
  // }

  // pathDenounce() {
  //   return user
  //       .doc(currentUsuario.value.id)
  //       .update({'qtyDenounce': currentUsuario.value.qtyDenounce});
  // }

  // pathLoginLogout(String status) {
  //   return user.doc(currentUsuario.value.id).update({
  //     "status": status,
  //     "token": currentToken.value,
  //   });
  // }

  // postBlockedUser(Map<String, dynamic> block) {
  //   return user.doc(block['blockedUserId']).set(block);
  // }

  // postBlockingUser(Map<String, dynamic> block) {
  //   return user.doc(block['blockingUser']).set(block);
  // }

  // pathQtyCommentUser(UsuarioModel user) {
  //   return user.doc(user.id).update({'qtdComentario': user.qtdComentario});
  // }

  // pathQtyDenounceUser(UsuarioModel user) {
  //   return user.doc(user.id).update({'qtyDenounce': user.qtyDenounce});
  // }
}
