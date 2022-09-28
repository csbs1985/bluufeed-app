import 'package:bluuffed_app/modal/comment_opiton_modal.dart';
import 'package:bluuffed_app/service/date_service.dart';
import 'package:bluuffed_app/theme/ui_border.dart';
import 'package:bluuffed_app/widget/date_widget.dart';
import 'package:flutter/material.dart';
import 'package:bluuffed_app/model/user_model.dart';
import 'package:bluuffed_app/theme/ui_color.dart';
import 'package:bluuffed_app/theme/ui_padding.dart';
import 'package:bluuffed_app/theme/ui_theme.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CommentItemWidget extends StatefulWidget {
  const CommentItemWidget({required Map<String, dynamic> item}) : _item = item;

  final Map<String, dynamic> _item;

  @override
  State<CommentItemWidget> createState() => _CommentItemWidgetState();
}

class _CommentItemWidgetState extends State<CommentItemWidget> {
  final UserClass userClass = UserClass();

  void _openModal(BuildContext context) {
    showCupertinoModalBottomSheet(
      expand: false,
      context: context,
      barrierColor: UiColor.overlay,
      duration: const Duration(milliseconds: 300),
      builder: (context) {
        return const CommentOptionModal();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTheme,
      builder: (BuildContext context, Brightness theme, _) {
        bool isDark = currentTheme.value == Brightness.dark;

        return GestureDetector(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: UiPadding.large),
            child: Column(
              crossAxisAlignment:
                  widget._item['userName'] == currentUser.value.first.name
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 0,
                  color: isDark ? UiColor.inativedDark : UiColor.inatived,
                  margin: const EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(UiBorder.rounded),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(UiPadding.medium),
                    child: Text(
                      widget._item['isDelete']
                          ? 'Comentário apagado!'.toUpperCase()
                          : widget._item['text'],
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    0,
                    UiPadding.small,
                    0,
                    UiPadding.large,
                  ),
                  child: DateWidget(
                    type: DateEnum.COMMENT.value,
                    item: widget._item,
                  ),
                )
              ],
            ),
          ),
          onLongPress: () => {
            _openModal(context),
          },
        );
      },
    );
  }
}
