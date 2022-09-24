import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:bluuffed_app/firestore/histories_firestore.dart';
import 'package:bluuffed_app/modal/comment_modal.dart';
import 'package:bluuffed_app/modal/input_comment_modal.dart';
import 'package:bluuffed_app/modal/send_modal.dart';
import 'package:bluuffed_app/model/history_model.dart';
import 'package:bluuffed_app/model/modal_model.dart';
import 'package:bluuffed_app/model/page_model.dart';
import 'package:bluuffed_app/model/user_model.dart';
import 'package:bluuffed_app/theme/ui_color.dart';
import 'package:bluuffed_app/theme/ui_icon.dart';
import 'package:bluuffed_app/theme/ui_padding.dart';
import 'package:bluuffed_app/theme/ui_size.dart';
import 'package:bluuffed_app/widget/icon_widget.dart';
import 'package:bluuffed_app/widget/number_animation_widget.dart';
import 'package:bluuffed_app/widget/toast_widget.dart';

class HistoryMenuWidget extends StatefulWidget {
  const HistoryMenuWidget({required Map<String, dynamic> history})
      : _history = history;

  final Map<String, dynamic> _history;

  @override
  State<HistoryMenuWidget> createState() => _HistoryMenuWidgetState();
}

class _HistoryMenuWidgetState extends State<HistoryMenuWidget> {
  final HistoryFirestore historyFirestore = HistoryFirestore();
  final HistoryClass historyClass = HistoryClass();
  final ToastWidget toast = ToastWidget();

  bool _isComment(String _route, Map<String, dynamic> _history) {
    if (_route == PageEnum.HISTORY.value) return false;
    if (_history['isComment']) return true;
    return false;
  }

  String _textComment() {
    if (!widget._history['isComment']) return 'comentário desabilitado';
    if (widget._history['qtyComment'] == 1) return ' comentário';
    if (widget._history['qtyComment'] > 1) return ' comentários';
    return 'seja o primeiro a comentar';
  }

  void _openComment() {
    if (widget._history['isComment']) {
      historyClass.add(widget._history);
      _openModal(context, ModalEnum.COMMENT.value);
    }
  }

  void _openModal(BuildContext context, String modalEnum) {
    showCupertinoModalBottomSheet(
      expand: true,
      context: context,
      barrierColor: UiColor.overley,
      duration: const Duration(milliseconds: 300),
      builder: (context) {
        if (modalEnum == ModalEnum.SEND.value) return const SendModal();
        if (modalEnum == ModalEnum.INPUT_COMMENT.value)
          return const InputCommentModal();
        else
          return const CommentModal();
      },
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
        toast.toast(
            context, ToastEnum.SUCCESS.value, 'história removida da lista');
      } else {
        history['bookmarks'].add(currentUser.value.first.id);
        toast.toast(context, ToastEnum.SUCCESS.value,
            'história adicionada à lista para ler mais tarde');
      }

      historyFirestore.pathBookmark(history);
    });
  }

  @override
  Widget build(BuildContext context) {
    var _route = ModalRoute.of(context)?.settings.name;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: UiPadding.medium),
      height: UiSize.historyMenu,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => _openComment(),
            child: Row(
              children: [
                if (widget._history['qtyComment'] > 0)
                  NumberAnimationWidget(number: widget._history['qtyComment']),
                Text(
                  _textComment(),
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
                  if (_isComment(_route!, widget._history))
                    IconWidget(
                      icon: UiIcon.comment,
                      callback: (value) {
                        historyClass.add(widget._history);
                        _openModal(context, ModalEnum.INPUT_COMMENT.value);
                      },
                    ),
                  const SizedBox(width: UiPadding.xLarge),
                  ValueListenableBuilder(
                    valueListenable: currentHistory,
                    builder: (BuildContext context, value, __) {
                      return IconWidget(
                        icon: _getBookmark(widget._history)
                            ? UiIcon.favoriteActived
                            : UiIcon.favorite,
                        callback: (value) {
                          _toggleBookmark(widget._history);
                        },
                      );
                    },
                  ),
                  const SizedBox(width: UiPadding.xLarge),
                  IconWidget(
                    icon: UiIcon.send,
                    callback: (value) {
                      historyClass.add(widget._history);
                      _openModal(context, ModalEnum.SEND.value);
                    },
                  ),
                  if (_route != PageEnum.HISTORY.value)
                    const SizedBox(width: UiPadding.xLarge),
                  if (_route != PageEnum.HISTORY.value)
                    IconWidget(
                      icon: UiIcon.read,
                      callback: (value) {
                        historyClass.add(widget._history);
                        Navigator.pushNamed(context, PageEnum.HISTORY.value);
                      },
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
