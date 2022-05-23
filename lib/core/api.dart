import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:universe_history_app/models/comment_model.dart';
import 'package:universe_history_app/models/history_model.dart';
import 'package:universe_history_app/models/user_model.dart';
import 'variables.dart';

class Api {
  CollectionReference activitie =
      FirebaseFirestore.instance.collection('activities');
  CollectionReference justification =
      FirebaseFirestore.instance.collection('justifications');
  CollectionReference block = FirebaseFirestore.instance.collection('blocks');
  CollectionReference bookmark =
      FirebaseFirestore.instance.collection('bookmarks');
  CollectionReference comment =
      FirebaseFirestore.instance.collection('comments');
  CollectionReference denounce =
      FirebaseFirestore.instance.collection('denounces');
  CollectionReference history =
      FirebaseFirestore.instance.collection('historys');
  CollectionReference notification =
      FirebaseFirestore.instance.collection('notifications');
  CollectionReference user = FirebaseFirestore.instance.collection('users');
  Future<String?> token = FirebaseMessaging.instance.getToken();

  getToken() {
    return token;
  }

  getTokenOwner(String _user) {
    return user.where('id', isEqualTo: _user).get();
  }

  setToken({String? token}) {
    return user.doc(currentUser.value.first.id).update({'token': token ?? ''});
  }

  setBlock(Map<String, dynamic> _form) {
    return block.doc(_form['id']).set(_form);
  }

  setDenounce(Map<String, dynamic> _form) {
    return denounce.doc(_form['id']).set(_form);
  }

  setJustify(Map<String, dynamic> _form) {
    return justification.doc(_form['id']).set(_form);
  }

  getAllBlock() {
    return block
        .orderBy('date')
        .where('blockerId', isEqualTo: currentUser.value.first.id)
        .snapshots();
  }

  getAllComment(String _idHistory) {
    return comment
        .orderBy('date', descending: true)
        .where('historyId', isEqualTo: _idHistory)
        .snapshots();
  }

  getAllHistory() {
    return history.orderBy('date').snapshots();
  }

  getAllHistoryFiltered(String _filter) {
    return history
        .orderBy('date')
        .where('categories', arrayContainsAny: [_filter]).snapshots();
  }

  getAllBookmarks() {
    return bookmark.orderBy('date').where('user',
        arrayContainsAny: [currentUser.value.first.id]).snapshots();
  }

  getAllUserHistory() {
    return history
        .orderBy('date')
        .where('userId', isEqualTo: currentUser.value.first.id)
        .get();
  }

  getHistoryUser() {
    return history
        .orderBy('date')
        .where('userId', isEqualTo: currentUser.value.first.id)
        .snapshots();
  }

  getAllUserComment() {
    return comment
        .orderBy('date')
        .where('userId', isEqualTo: currentUser.value.first.id)
        .get();
  }

  getHistory(String _idHistory) {
    return history.where('id', isEqualTo: _idHistory).snapshots();
  }

  getComment(String _id) {
    return comment.where('id', isEqualTo: _id).get();
  }

  getUser(String? _email) {
    return user.where('email', isEqualTo: _email).get();
  }

  getNickName(String _nickname) {
    return user.where('nickname', isEqualTo: _nickname).get();
  }

  getUsersNickName(String _nickname) {
    return user
        .where('nickname', arrayContainsAny: ['_nickname'])
        .orderBy('nickname')
        .snapshots();
  }

  setHistory(Map<String, dynamic> _form) {
    return history.doc(_form['id']).set(_form);
  }

  setNotification(Map<String, dynamic> _form) {
    return notification.doc(_form['id']).set(_form);
  }

  setActivities(Map<String, dynamic> _form) {
    return activitie.doc().set(_form);
  }

  setComment(Map<String, dynamic> _form) {
    return comment.doc(_form['id']).set(_form);
  }

  setUser(Map<String, dynamic> _form) {
    return user.doc(currentUser.value.first.id).set(_form);
  }

  upBookmarks() {
    return bookmark
        .doc(currentUser.value.first.id)
        .update({'historyId': currentBookmarks.value});
  }

  upNumComment() {
    return history
        .doc(currentHistory.value.first.id)
        .update({'qtyComment': currentHistory.value.first.qtyComment});
  }

  upNicknameHistory(String _id) {
    return history
        .doc(_id)
        .update({'userNickName': currentUser.value.first.nickname});
  }

  upStatusUser(String _status) {
    return user.doc(currentUser.value.first.id).update({'status': _status});
  }

  upToken(String _status) {
    return user.doc(currentUser.value.first.id).update({'status': _status});
  }

  upNicknameComment(String _id) {
    return comment
        .doc(_id)
        .update({'userNickName': currentUser.value.first.nickname});
  }

  upStatusUserComment(String _id) {
    return comment
        .doc(_id)
        .update({'userStatus': UserStatus.DELETED.toString().split('.').last});
  }

  upNotification(String _idNotification) {
    return notification.doc(_idNotification).update({'view': true});
  }

  deleteComment() {
    return comment
        .doc(currentComment.value.first.id)
        .update({'isDelete': true});
  }

  deleteHistory(String _idHistory) {
    return history.doc(_idHistory).delete();
  }

  deleteUser(String _idUser) {
    return user.doc(_idUser).delete();
  }

  deleteBlock(String blocked) {
    return block.doc(blocked).delete();
  }

  upNickName() {
    return user.doc(currentUser.value.first.id).update({
      'nickname': currentUser.value.first.nickname,
      'upDateNickname': currentUser.value.first.upDateNickname
    });
  }

  toggleNotification() {
    return user
        .doc(currentUser.value.first.id)
        .update({'isNotification': currentUser.value.first.isNotification});
  }

  setUpQtyHistoryUser() {
    return user
        .doc(currentUser.value.first.id)
        .update({'qtyHistory': currentUser.value.first.qtyHistory});
  }

  setUpQtyCommentUser() {
    return user
        .doc(currentUser.value.first.id)
        .update({'qtyComment': currentUser.value.first.qtyComment});
  }
}
