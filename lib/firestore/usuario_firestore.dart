import 'package:bluufeed_app/class/usuario_class.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UsuarioFirestore {
  CollectionReference usuarios =
      FirebaseFirestore.instance.collection('usuarios');

  getUsuarioEmail(String email) async {
    return usuarios.where('email', isEqualTo: email).get();
  }

  pathQtdFavoritos(UsuarioModel _usuario) {
    return usuarios
        .doc(_usuario.idUsuario)
        .update({'qtyBookmark': _usuario.qtdFavoritos});
  }

  pathQtdHistorias(UsuarioModel _usuario) async {
    await usuarios
        .doc(_usuario.idUsuario)
        .update({"qtyHistory": _usuario.qtdHistorias});
  }

  pathSeguindo(List<String> _seguindo) {
    return usuarios
        .doc(currentUsuario.value.idUsuario)
        .update({'seguindo': _seguindo});
  }

  postUsuario(Map<String, dynamic> _usuario) {
    return usuarios.doc(_usuario['idUsuario']).set(_usuario);
  }

  // deleteUser() {
  //   return user.doc(currentUsuario.value.id).delete();
  // }

  // getTokenOwner(String user) {
  //   return user.where('id', isEqualTo: user).get();
  // }

  // getName(String nickname) {
  //   return user.where('name', isEqualTo: nickname).get();
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

  // pathNotification() {
  //   return user
  //       .doc(currentUsuario.value.id)
  //       .update({'isNotification': currentUsuario.value.isNotification});
  // }

  // pathDenounce() {
  //   return user
  //       .doc(currentUsuario.value.id)
  //       .update({'qtyDenounce': currentUsuario.value.qtyDenounce});
  // }

  // pathName(String name, String now) {
  //   return user.doc(currentUsuario.value.id).update({
  //     'name': name,
  //     'upDateName': now,
  //   });
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
