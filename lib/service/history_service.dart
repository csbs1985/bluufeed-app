import 'package:bluuffed_app/firestore/comments_firestore.dart';
import 'package:bluuffed_app/firestore/history_firestore.dart';
import 'package:bluuffed_app/model/activity_model.dart';
import 'package:bluuffed_app/model/history_model.dart';
import 'package:bluuffed_app/service/comment_service.dart';
import 'package:bluuffed_app/widget/toast_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:no_context_navigation/no_context_navigation.dart';

class HistoryService {
  final ActivityClass activityClass = ActivityClass();
  final CommentFirestore commentFirestore = CommentFirestore();
  final CommentService commentService = CommentService();
  final HistoryClass historyClass = HistoryClass();
  final HistoryFirestore historyFirestore = HistoryFirestore();
  final NavigationService navService = NavigationService();
  final ToastWidget toastWidget = ToastWidget();

  late Map<String, dynamic> _history;

  Future<void> getHistoryPage(String _historyId) async {
    try {
      await historyFirestore.getHistory(_historyId).then(
            (result) => {
              _history = {
                'id': result.docs[0]['id'],
                'title': result.docs[0]['title'],
                'text': result.docs[0]['text'],
                'date': result.docs[0]['date'],
                'isComment': result.docs[0]['isComment'],
                'isSigned': result.docs[0]['isSigned'],
                'isEdit': result.docs[0]['isEdit'],
                'isAuthorized': result.docs[0]['isAuthorized'],
                'qtyComment': result.docs[0]['qtyComment'],
                'categories': result.docs[0]['categories'],
                'userId': result.docs[0]['userId'],
                'userName': result.docs[0]['userName'],
                'bookmarks': result.docs[0]['bookmarks'],
              },
              historyClass.add(_history),
            },
          );

      NavigationService.navigationKey.currentState!.pushNamed('/history');
      // navService.pushNamed('/history');
      // Navigator.pushNamed(context, PageEnum.HISTORY.value);
    } on FirebaseAuthException catch (error) {
      debugPrint('ERROR => getHistory: ' + error.toString());
    }
  }

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
    BuildContext context,
    Map<String, dynamic> _history,
  ) async {
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
        'história deletada',
      );
    } on FirebaseAuthException catch (error) {
      debugPrint('ERROR => deleteComment: ' + error.toString());
    }
  }
}
