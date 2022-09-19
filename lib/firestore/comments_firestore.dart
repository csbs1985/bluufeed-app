import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:universe_history_app/model/comment_model.dart';
import 'package:universe_history_app/model/user_model.dart';

class CommentFirestore {
  CollectionReference comments =
      FirebaseFirestore.instance.collection('comments');

  deleteComment() {
    return comments
        .doc(currentComment.value.first.id)
        .update({'isDelete': true});
  }

  getAllCommentUser() {
    return comments
        .orderBy('date')
        .where('userId', isEqualTo: currentUser.value.first.id)
        .get();
  }

  getComment(String _id) {
    return comments.where('id', isEqualTo: _id).get();
  }

  pathNameUserComment(String _id) {
    return comments.doc(_id).update({'userName': currentUser.value.first.name});
  }

  postComment(Map<String, dynamic> _comment) {
    return comments.doc(_comment['id']).set(_comment);
  }

  upStatusUserComment(String _id) {
    return comments
        .doc(_id)
        .update({'userStatus': UserStatusEnum.DELETED.name});
  }
}
