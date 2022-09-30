import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bluuffed_app/model/history_model.dart';
import 'package:bluuffed_app/model/user_model.dart';

class HistoryFirestore {
  CollectionReference histories =
      FirebaseFirestore.instance.collection('histories');

  deleteHistory(String _idHistory) {
    return histories.doc(_idHistory).delete();
  }

  getAllHistoryUser() {
    return histories
        .orderBy('date')
        .where('userId', isEqualTo: currentUser.value.first.id)
        .get();
  }

  getHistory(String _idHistory) {
    return histories.where('id', isEqualTo: _idHistory).snapshots();
  }

  getHistoryNotification(String _idHistory) {
    return histories.where('id', isEqualTo: _idHistory).get();
  }

  pathNameUserHistory(String _id) {
    return histories
        .doc(_id)
        .update({'userName': currentUser.value.first.name});
  }

  pathQtyCommentHistory(HistoryModel _history) {
    return histories
        .doc(_history.id)
        .update({'qtyComment': _history.qtyComment});
  }

  pathBookmark(Map<String, dynamic> _history) {
    return histories
        .doc(_history['id'])
        .update({'bookmarks': _history['bookmarks']});
  }

  postHistory(Map<String, dynamic> _history) {
    return histories.doc(_history['id']).set(_history);
  }
}
