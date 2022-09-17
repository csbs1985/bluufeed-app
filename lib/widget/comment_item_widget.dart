import 'package:flutter/material.dart';
import 'package:universe_history_app/modal/comment_modal.dart';
import 'package:universe_history_app/model/user_model.dart';
import 'package:universe_history_app/theme/ui_border.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_padding.dart';
import 'package:universe_history_app/widget/date_widget.dart';
import 'package:universe_history_app/widget/label_widget.dart';

class CommentItemWidget extends StatefulWidget {
  const CommentItemWidget({required Map<String, dynamic> item}) : _item = item;

  final Map<String, dynamic> _item;

  @override
  State<CommentItemWidget> createState() => _CommentItemWidgetState();
}

class _CommentItemWidgetState extends State<CommentItemWidget> {
  final UserClass userClass = UserClass();

  Color _getBackColor(index) {
    if (index['text'].contains('@${currentUser.value.first.name}'))
      return UiColor.primary;
    return UiColor.buttonSecondary;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: UiPadding.large),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            child: Card(
              color: _getBackColor(widget._item),
              margin: const EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(UiBorder.rounded),
              ),
              child: Padding(
                padding: const EdgeInsets.all(UiPadding.medium),
                child: LabelWidget(
                  label: widget._item['isDelete']
                      ? 'Comentário apagado!'.toUpperCase()
                      : widget._item['text'],
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(
              0,
              UiPadding.small,
              0,
              UiPadding.large,
            ),
            child: DateWidget(
              type: CommentTypeEnum.COMMENT.value,
              item: widget._item,
            ),
          )
        ],
      ),
    );
  }
}
