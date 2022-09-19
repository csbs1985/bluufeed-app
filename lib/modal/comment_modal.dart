import 'package:flutter/material.dart';
import 'package:universe_history_app/firestore/comments_firestore.dart';
import 'package:universe_history_app/model/history_model.dart';
import 'package:universe_history_app/model/user_model.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_size.dart';
import 'package:universe_history_app/theme/ui_theme.dart';
import 'package:universe_history_app/widget/button_comment_widget.dart';
import 'package:universe_history_app/widget/comment_list_widget.dart';
import 'package:universe_history_app/widget/number_animation_widget.dart';

class CommentModal extends StatefulWidget with PreferredSizeWidget {
  const CommentModal({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<CommentModal> createState() => _CommentModalState();
}

class _CommentModalState extends State<CommentModal> {
  final CommentFirestore commentFirestore = CommentFirestore();

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
        // if (currentHistory.value.first.qtyComment > 0)
        NumberAnimationWidget(number: currentHistory.value.first.qtyComment),
        Text(
          _showComment(currentHistory.value.first),
          style: Theme.of(context).textTheme.headline4,
        ),
      ],
    );
  }

  Widget _list() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const CommentListWidget(),
          if (currentUser.value.isNotEmpty)
            const SizedBox(height: UiSize.bottomNavigation),
        ],
      ),
    );
  }
}

enum CommentTypeEnum {
  COMMENT('comment'),
  HISTORY('history');

  final String value;
  const CommentTypeEnum(this.value);
}
