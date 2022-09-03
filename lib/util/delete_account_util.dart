import 'package:flutter/material.dart';
import 'package:universe_history_app/firestore/comments_firestore.dart';
import 'package:universe_history_app/firestore/histories_firestore.dart';
import 'package:universe_history_app/firestore/justifications_Firestore.dart';
import 'package:universe_history_app/core/variables.dart';
import 'package:universe_history_app/model/user_model.dart';
import 'package:universe_history_app/service/auth_service.dart';
import 'package:universe_history_app/widget/loader_widget.dart';
import 'package:uuid/uuid.dart';

class DeleteAccountUtil {
  final CommentsFirestore commentsFirestore = CommentsFirestore();
  final HistoriesFirestore historiesFirestore = HistoriesFirestore();
  final JustificationsFirestore justificationsFirestore =
      JustificationsFirestore();
  final UserClass userClass = UserClass();
  Uuid uuid = const Uuid();

  late Map<String, dynamic> _form;

  Future<void> deleteAccount(BuildContext context, justifySelected) async {
    Navigator.of(context).pop();

    currentDialog.value = 'Iniciando...';

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const LoaderWidget();
        });

    if (justifySelected == null)
      _deleteAllHistory(context);
    else
      _form = {
        'id': uuid.v4(),
        'date': DateTime.now().toString(),
        'userId': currentUser.value.first.id,
        'userName': currentUser.value.first.name,
        'idJustify': justifySelected!.id,
        'titleJustify': justifySelected!.title
      };

    try {
      await justificationsFirestore.postJustify(_form);
      currentDialog.value = 'Justificando...';
      _deleteAllHistory(context);
    } on AuthException catch (error) {
      debugPrint('ERROR => _deleteAllHistory: $error');
    }
  }

  Future<void> _deleteAllHistory(BuildContext context) async {
    await historiesFirestore
        .getAllHistoryUser()
        .then((result) async => {
              if (result.size > 0)
                currentDialog.value = 'Deletando histórias...',
              for (var item in result.docs)
                await historiesFirestore.deleteHistory(item['id']),
              _deleteAllComment(context)
            })
        .catchError((error) => debugPrint('ERROR:' + error));
  }

  _deleteAllComment(BuildContext context) async {
    await commentsFirestore
        .getAllCommentUser()
        .then((result) async => {
              if (result.size > 0)
                currentDialog.value = 'Atualizando comentários...',
              for (var item in result.docs)
                await commentsFirestore.upStatusUserComment(item['id']),
              userClass.delete(context)
            })
        .catchError((error) => debugPrint('ERROR:' + error));
  }
}
