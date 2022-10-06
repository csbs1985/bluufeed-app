import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:bluuffed_app/firestore/comments_firestore.dart';
import 'package:bluuffed_app/model/history_model.dart';
import 'package:bluuffed_app/skeleton/comment_skeleton.dart';
import 'package:bluuffed_app/widget/comment_item_widget.dart';
import 'package:bluuffed_app/widget/no_result_widget.dart';

class CommentListWidget extends StatefulWidget {
  const CommentListWidget({super.key});

  @override
  State<CommentListWidget> createState() => _CommentListWidgetState();
}

class _CommentListWidgetState extends State<CommentListWidget> {
  final CommentFirestore commentFirestore = CommentFirestore();

  @override
  Widget build(BuildContext context) {
    return FirestoreListView(
      query: commentFirestore.comments
          .orderBy('date')
          .where('historyId', isEqualTo: currentHistory.value.first.id),
      pageSize: 20,
      shrinkWrap: true,
      reverse: true,
      physics: const NeverScrollableScrollPhysics(),
      loadingBuilder: (context) => const CommentSkeleton(),
      errorBuilder: (context, error, _) => const NoResultWidget(
        text: 'Nenhum comentário ainda, ou os comentários foram desativados.',
      ),
      itemBuilder:
          (BuildContext context, QueryDocumentSnapshot<dynamic> snapshot) {
        return CommentItemWidget(item: snapshot.data());
      },
    );
  }
}
