import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:universe_history_app/firestore/comments_firestore.dart';
import 'package:universe_history_app/model/history_model.dart';
import 'package:universe_history_app/model/user_model.dart';
import 'package:universe_history_app/skeleton/comment_skeleton.dart';
import 'package:universe_history_app/theme/ui_border.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_padding.dart';
import 'package:universe_history_app/theme/ui_size.dart';
import 'package:universe_history_app/theme/ui_theme.dart';
import 'package:universe_history_app/util/resume_util.dart';
import 'package:universe_history_app/widget/button_comment_widget.dart';
import 'package:universe_history_app/widget/no_result_widget.dart';

class CommentModal extends StatefulWidget with PreferredSizeWidget {
  const CommentModal({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<CommentModal> createState() => _CommentModalState();
}

class _CommentModalState extends State<CommentModal> {
  final CommentsFirestore commentsFirestore = CommentsFirestore();
  final UserClass userClass = UserClass();

  String _showComment(history) {
    if (!history.isComment) return 'comentário desabilitado';
    if (history.qtyComment == 1) return ' comentário';
    if (history.qtyComment > 1) return ' comentários';
    return 'seja o primeiro a comentar';
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTheme,
      builder: (BuildContext context, Brightness theme, _) {
        bool isDark = currentTheme.value == Brightness.dark;

        return Material(
          type: MaterialType.transparency,
          child: Stack(
            children: [
              Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: isDark ? UiColor.mainDark : UiColor.main,
                  elevation: 0,
                  leadingWidth: 100,
                  title: _appBar(),
                ),
                body: _list(),
              ),
              const ButtonCommentWidget(),
            ],
          ),
        );
      },
    );
  }

  Widget _appBar() {
    return Row(
      children: [
        if (currentHistory.value.first.qtyComment > 0)
          AnimatedFlipCounter(
            duration: const Duration(milliseconds: 500),
            value: currentHistory.value.first.qtyComment,
            textStyle: Theme.of(context).textTheme.headline4,
          ),
        Text(
          _showComment(currentHistory.value.first),
          style: Theme.of(context).textTheme.headline4,
        ),
      ],
    );
  }

  bool _canShowOption(dynamic content) {
    if (userClass.isLogin()) {
      if (!content['isDelete'] &&
          currentUser.value.first.id == content['userId']) return true;
      if (!content['isDelete']) return true;
    }
    return false;
  }

  Color _getBackColor(index) {
    if (userClass.isLogin()) {
      if (index['text'].contains('@${currentUser.value.first.name}'))
        return UiColor.primary;
      if (index['userId'] == currentUser.value.first.id)
        return UiColor.secondary;
    }
    return UiColor.primary;
  }

  Widget _list() {
    return SingleChildScrollView(
      child: Column(
        children: [
          FirestoreListView(
            query: commentsFirestore.comments
                .orderBy('date')
                .where('historyId', isEqualTo: currentHistory.value.first.id),
            pageSize: 20,
            shrinkWrap: true,
            reverse: true,
            physics: const NeverScrollableScrollPhysics(),
            loadingBuilder: (context) => CommentSkeleton(),
            errorBuilder: (context, error, _) => const NoResultWidget(
                text:
                    'Nenhum comentário ainda, ou os comentários foram desativados.'),
            itemBuilder: (BuildContext context,
                QueryDocumentSnapshot<dynamic> snapshot) {
              return _comment(snapshot.data());
            },
          ),
          // if (currentUser.value.isNotEmpty)
          const SizedBox(height: UiSize.bottomNavigation),
        ],
      ),
    );
  }

  Widget _comment(Map<String, dynamic> item) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        UiPadding.large,
        0,
        UiPadding.large,
        0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            // onLongPress:
            // _canShowOption(item) ? () => _showModal(context, item) : null,
            child: Card(
              color: _getBackColor(item),
              margin: const EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  UiBorder.rounded,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 6, 10, 8),
                child: Text(
                  item['isDelete']
                      ? 'Comentário apagado!'.toUpperCase()
                      : item['text'],
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(2, 4, 0, 16),
            child: Text(
              resumeUitl(
                item,
                type: ContentType.COMMENT.name,
              ),
              style: Theme.of(context).textTheme.headline4,
            ),
          )
        ],
      ),
    );
  }
}
