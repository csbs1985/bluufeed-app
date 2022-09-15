import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:universe_history_app/model/user_model.dart';

class UserFirestore {
  CollectionReference user = FirebaseFirestore.instance.collection('users');

  deleteUser() {
    return user.doc(currentUser.value.first.id).delete();
  }

  getUserEmail(String? _email) {
    return user.where('email', isEqualTo: _email).get();
  }

  pathNotification() {
    return user
        .doc(currentUser.value.first.id)
        .update({'isNotification': currentUser.value.first.isNotification});
  }

  pathName() {
    return user.doc(currentUser.value.first.id).update({
      'name': currentUser.value.first.name,
      'upDateName': currentUser.value.first.upDateName
    });
  }

  pathLoginLogout(String _status, {String? token}) {
    return user.doc(currentUser.value.first.id).update({
      "status": _status,
      "token": token ?? '',
    });
  }

  pathQtyCommentUser(UserModel _user) {
    return user.doc(_user.id).update({'qtyComment': _user.qtyComment});
  }

  pathQtyHistoryUser(UserModel _user) async {
    await user.doc(_user.id).update({"qtyHistory": _user.qtyHistory});
  }

  postUser(Map<String, dynamic> _user) {
    return user.doc(_user['id']).set(_user);
  }

  getTokenOwner(String _user) {
    return user.where('id', isEqualTo: _user).get();
  }

  getName(String _nickname) {
    return user.where('name', isEqualTo: _nickname).get();
  }
}
