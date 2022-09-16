import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:universe_history_app/firestore/histories_firestore.dart';
import 'package:universe_history_app/modal/comment_modal.dart';
import 'package:universe_history_app/modal/input_comment_modal.dart';
import 'package:universe_history_app/model/history_model.dart';
import 'package:universe_history_app/model/modal_model.dart';
import 'package:universe_history_app/model/page_model.dart';
import 'package:universe_history_app/model/user_model.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_icon.dart';
import 'package:universe_history_app/theme/ui_padding.dart';
import 'package:universe_history_app/theme/ui_size.dart';
import 'package:universe_history_app/widget/icon_widget.dart';
import 'package:universe_history_app/widget/number_animation_widget.dart';
import 'package:universe_history_app/widget/toast_widget.dart';

class HistoryMenuWidget extends StatefulWidget {
  const HistoryMenuWidget({required Map<String, dynamic> history})
      : _history = history;

  final Map<String, dynamic> _history;

  @override
  State<HistoryMenuWidget> createState() => _HistoryMenuWidgetState();
}

class _HistoryMenuWidgetState extends State<HistoryMenuWidget> {
  final HistoriesFirestore historiesFirestore = HistoriesFirestore();
  final HistoryClass historyClass = HistoryClass();
  final ToastWidget toast = ToastWidget();

  String _showComment() {
    if (!widget._history['isComment']) return 'comentário desabilitado';
    if (widget._history['qtyComment'] == 1) return ' comentário';
    if (widget._history['qtyComment'] > 1) return ' comentários';
    return 'seja o primeiro a comentar';
  }

  void _openComment() {
    if (widget._history['isComment']) {
      currentHistoryId.value = widget._history['id'];
      _showModal(context, ModalEnum.COMMENT.value);
    }
  }

  void _showModal(BuildContext context, String modalEnum) {
    showCupertinoModalBottomSheet(
      expand: true,
      context: context,
      barrierColor: UiColor.overley,
      duration: const Duration(milliseconds: 300),
      builder: (context) => modalEnum == ModalEnum.COMMENT.value
          ? const CommentModal()
          : const InputCommentModal(),
    );
  }

  bool _getBookmark(history) {
    return history['bookmarks'].contains(currentUser.value.first.id)
        ? true
        : false;
  }

  void _toggleBookmark(history) {
    setState(() {
      if (history['bookmarks'].contains(currentUser.value.first.id)) {
        history['bookmarks'].remove(currentUser.value.first.id);
        toast.toast(context, ToastEnum.SUCCESS.value,
            'História removida dos favoritos');
      } else {
        history['bookmarks'].add(currentUser.value.first.id);
        toast.toast(context, ToastEnum.SUCCESS.value,
            'História adicionada aos favoritos');
      }

      historiesFirestore.pathBookmark(history);
    });
  }

  @override
  Widget build(BuildContext context) {
    var _item = widget._history;
    return SizedBox(
      height: UiSize.historyMenu,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: UiPadding.medium),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => _openComment(),
              child: Row(
                children: [
                  if (_item['qtyComment'] > 0)
                    NumberAnimationWidget(number: _item['qtyComment']),
                  Text(
                    _showComment(),
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
            ),
            ValueListenableBuilder(
              valueListenable: currentUser,
              builder: (BuildContext context, value, __) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (_item['isComment'])
                      IconWidget(
                        icon: UiIcon.comment,
                        callback: (value) {
                          setState(
                            () {
                              currentHistoryId.value = _item['id'];
                              _showModal(
                                  context, ModalEnum.INPUT_COMMENT.value);
                            },
                          );
                        },
                      ),
                    const SizedBox(width: UiPadding.xLarge),
                    ValueListenableBuilder(
                      valueListenable: currentHistory,
                      builder: (BuildContext context, value, __) {
                        return IconWidget(
                          icon: _getBookmark(_item)
                              ? UiIcon.favoriteActived
                              : UiIcon.favorite,
                          callback: (value) {
                            _toggleBookmark(_item);
                          },
                        );
                      },
                    ),
                    const SizedBox(width: UiPadding.xLarge),
                    IconWidget(
                      icon: UiIcon.read,
                      callback: (value) {
                        currentHistoryId.value = _item['id'];
                        Navigator.pushNamed(context, PageEnum.HISTORY.value);
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
