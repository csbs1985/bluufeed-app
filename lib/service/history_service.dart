import 'package:bluuffed_app/firestore/comments_firestore.dart';
import 'package:bluuffed_app/firestore/history_firestore.dart';
import 'package:bluuffed_app/model/activity_model.dart';
import 'package:bluuffed_app/service/comment_service.dart';
import 'package:bluuffed_app/widget/toast_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class HistoryService {
  final ActivityClass activityClass = ActivityClass();
  final CommentFirestore commentFirestore = CommentFirestore();
  final CommentService commentService = CommentService();
  final HistoryFirestore historyFirestore = HistoryFirestore();
  final ToastWidget toastWidget = ToastWidget();

  Future<void> pathAllHistory() async {
    await historyFirestore
        .getAllHistoryUser()
        .then((result) async => {
              if (result.size > 0)
                for (var item in result.docs)
                  await historyFirestore.pathNameUserHistory(item['id']),
            })
        .catchError((error) => debugPrint('ERROR:' + error.toString()));
  }

  void deleteHistory(
      BuildContext context, Map<String, dynamic> _history) async {
    Navigator.of(context).pop();

    try {
      await historyFirestore
          .deleteHistory(_history['id'])
          .then((result) =>
              {commentService.deleteAllComments(context, _history['id'])})
          .catchError((error) =>
              debugPrint('ERROR => deleteHistory:' + error.toString()));
      Navigator.of(context).pop();
      activityClass.save(
        type: ActivityEnum.DELETE_HISTORY.value,
        content: _history['text'],
        elementId: _history['userName'],
      );
      toastWidget.toast(
        context,
        ToastEnum.SUCCESS.value,
        'história deletada!',
      );
    } on FirebaseAuthException catch (error) {
      debugPrint('ERROR => deleteComment: ' + error.toString());
    }
  }
}
