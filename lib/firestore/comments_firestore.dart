import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bluuffed_app/model/user_model.dart';

class CommentFirestore {
  CollectionReference comments =
      FirebaseFirestore.instance.collection('comments');

  deleteComment(String _commentId) {
    return comments.doc(_commentId).update({'isDelete': true});
  }

  getCommentHistory(String _historyId) {
    return comments
        .orderBy('date')
        .where('historyId', isEqualTo: _historyId)
        .get();
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
