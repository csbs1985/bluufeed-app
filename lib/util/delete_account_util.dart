import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bluuffed_app/firestore/comments_firestore.dart';
import 'package:bluuffed_app/firestore/history_firestore.dart';
import 'package:bluuffed_app/firestore/justifications_Firestore.dart';
import 'package:bluuffed_app/core/variables.dart';
import 'package:bluuffed_app/model/user_model.dart';
import 'package:bluuffed_app/widget/loader_widget.dart';
import 'package:uuid/uuid.dart';

class DeleteAccountUtil {
  final CommentFirestore commentFirestore = CommentFirestore();
  final HistoryFirestore historyFirestore = HistoryFirestore();
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
    } on FirebaseAuthException catch (error) {
      debugPrint('ERROR => _deleteAllHistory: $error');
    }
  }

  Future<void> _deleteAllHistory(BuildContext context) async {
    await historyFirestore
        .getAllHistoryUser()
        .then((result) async => {
              if (result.size > 0)
                currentDialog.value = 'Deletando histórias...',
              for (var item in result.docs)
                await historyFirestore.deleteHistory(item['id']),
              _deleteAllComment(context)
            })
        .catchError((error) => debugPrint('ERROR:' + error));
  }

  _deleteAllComment(BuildContext context) async {
    await commentFirestore
        .getAllCommentUser()
        .then((result) async => {
              if (result.size > 0)
                currentDialog.value = 'Atualizando comentários...',
              for (var item in result.docs)
                await commentFirestore.upStatusUserComment(item['id']),
              userClass.delete(context)
            })
        .catchError((error) => debugPrint('ERROR:' + error));
  }
}
