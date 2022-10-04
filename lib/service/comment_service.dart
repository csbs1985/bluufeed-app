import 'package:bluuffed_app/firestore/comments_firestore.dart';
import 'package:bluuffed_app/model/activity_model.dart';
import 'package:bluuffed_app/widget/toast_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class CommentService {
  final ActivityClass activityClass = ActivityClass();
  final CommentFirestore commentFirestore = CommentFirestore();
  final ToastWidget toastWidget = ToastWidget();

  Future<void> pathAllComment() async {
    await commentFirestore
        .getAllCommentUser()
        .then((result) async => {
              if (result.size > 0)
                for (var item in result.docs)
                  await commentFirestore.pathNameUserComment(item['id']),
            })
        .catchError((error) => debugPrint('ERROR:' + error.toString()));
  }

  void deleteComment(
      BuildContext context, Map<String, dynamic> _comment) async {
    Navigator.of(context).pop();

    try {
      await commentFirestore
          .deleteComment(_comment['id'])
          .then((result) => {
                activityClass.save(
                  type: ActivityEnum.DELETE_COMMENT.value,
                  content: _comment['text'],
                  elementId: _comment['userName'],
                ),
              })
          .catchError((error) =>
              debugPrint('ERROR => deleteHistory:' + error.toString()));
      Navigator.of(context).pop();
      activityClass.save(
        type: ActivityEnum.DELETE_COMMENT.value,
        content: _comment['text'],
        elementId: _comment['userName'],
      );
      toastWidget.toast(
        context,
        ToastEnum.SUCCESS.value,
        'comentário deletado!',
      );
    } on FirebaseAuthException catch (error) {
      debugPrint('ERROR => deleteComment: ' + error.toString());
    }
  }

  Future<void> deleteAllComments(
      BuildContext context, String _historyId) async {
    try {
      await commentFirestore.getCommentHistory(_historyId).then(
            (result) async => {
              for (var item in result.docs)
                await commentFirestore.deleteComment(item.id),
              Navigator.of(context).pop(),
            },
          );
    } on FirebaseAuthException catch (error) {
      debugPrint('ERROR => deleteAllCommentUser: ' + error.toString());
    }
  }
}
