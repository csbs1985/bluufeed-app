import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bluuffed_app/model/history_model.dart';
import 'package:bluuffed_app/model/user_model.dart';

class HistoryFirestore {
  CollectionReference stories =
      FirebaseFirestore.instance.collection('stories');

  deleteHistory(String _idHistory) {
    return stories.doc(_idHistory).delete();
  }

  getAllHistoryUser() {
    return stories
        .orderBy('date')
        .where('userId', isEqualTo: currentUser.value.first.id)
        .get();
  }

  snapshotsHistory(String _idHistory) {
    return stories.where('id', isEqualTo: _idHistory).snapshots();
  }

  getHistory(String _idHistory) {
    return stories.where('id', isEqualTo: _idHistory).get();
  }

  getHistoryNotification(String _idHistory) {
    return stories.where('id', isEqualTo: _idHistory).get();
  }

  pathNameUserHistory(String _id) {
    return stories.doc(_id).update({'userName': currentUser.value.first.name});
  }

  pathQtyCommentHistory(HistoryModel _history) {
    return stories.doc(_history.id).update({'qtyComment': _history.qtyComment});
  }

  pathBookmark(Map<String, dynamic> _history) {
    return stories
        .doc(_history['id'])
        .update({'bookmarks': _history['bookmarks']});
  }

  postHistory(Map<String, dynamic> _history) {
    return stories.doc(_history['id']).set(_history);
  }
}
