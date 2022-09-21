import 'package:bluuffed_app/firestore/comments_firestore.dart';
import 'package:flutter/cupertino.dart';

class CommentService {
  final CommentFirestore commentFirestore = CommentFirestore();

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
}
