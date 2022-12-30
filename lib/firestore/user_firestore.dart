import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bluuffed_app/model/user_model.dart';

class UserFirestore {
  CollectionReference user = FirebaseFirestore.instance.collection('users');

  deleteUser() {
    return user.doc(currentUser.value.first.id).delete();
  }

  getTokenOwner(String _user) {
    return user.where('id', isEqualTo: _user).get();
  }

  getName(String _nickname) {
    return user.where('name', isEqualTo: _nickname).get();
  }

  getUserEmail(String _email) {
    return user.where('email', isEqualTo: _email).get();
  }

  getUserId(String? _id) {
    return user.where('id', isEqualTo: _id).get();
  }

  snapshotsUserId(String _id) {
    return user.where('id', isEqualTo: _id).snapshots();
  }

  pathBio(String _bio) {
    return user.doc(currentUser.value.first.id).update({'bio': _bio});
  }

  pathFallowing(List<dynamic> _following) {
    return user
        .doc(currentUser.value.first.id)
        .update({'following': _following});
  }

  pathNotification() {
    return user
        .doc(currentUser.value.first.id)
        .update({'isNotification': currentUser.value.first.isNotification});
  }

  pathDenounce() {
    return user
        .doc(currentUser.value.first.id)
        .update({'qtyDenounce': currentUser.value.first.qtyDenounce});
  }

  pathName(String _name, String _now) {
    return user.doc(currentUser.value.first.id).update({
      'name': _name,
      'upDateName': _now,
    });
  }

  pathLoginLogout(String _status) {
    return user.doc(currentUser.value.first.id).update({
      "status": _status,
      "token": currentToken.value,
    });
  }

  postBlockedUser(Map<String, dynamic> _block) {
    return user.doc(_block['blockedUserId']).set(_block);
  }

  postBlockingUser(Map<String, dynamic> _block) {
    return user.doc(_block['blockingUser']).set(_block);
  }

  pathQtyCommentUser(UserModel _user) {
    return user.doc(_user.id).update({'qtyComment': _user.qtyComment});
  }

  pathQtyBookmarkUser(UserModel _user) {
    return user.doc(_user.id).update({'qtyBookmark': _user.qtyBookmark});
  }

  pathQtyDenounceUser(UserModel _user) {
    return user.doc(_user.id).update({'qtyDenounce': _user.qtyDenounce});
  }

  pathQtyHistoryUser(UserModel _user) async {
    await user.doc(_user.id).update({"qtyHistory": _user.qtyHistory});
  }

  postUser(Map<String, dynamic> _user) {
    return user.doc(_user['id']).set(_user);
  }
}
