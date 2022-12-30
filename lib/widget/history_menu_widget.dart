import 'package:bluuffed_app/firestore/user_firestore.dart';
import 'package:bluuffed_app/service/history_service.dart';
import 'package:bluuffed_app/theme/ui_border.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:bluuffed_app/firestore/history_firestore.dart';
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
  final HistoryClass historyClass = HistoryClass();
  final HistoryFirestore historyFirestore = HistoryFirestore();
  final HistoryService historyService = HistoryService();
  final ToastWidget toast = ToastWidget();
  final UserFirestore userFirestore = UserFirestore();

  bool _isComment(String? _route, Map<String, dynamic> _history) {
    if (_route == PageEnum.HISTORY.value) return false;
    if (_history['isComment']) return true;
    return false;
  }

  String _textComment() {
    if (!widget._history['isComment']) return 'comentário desabilitado';
    if (widget._history['qtyComment'] == 1) return ' comentário';
    if (widget._history['qtyComment'] > 1) return ' comentários';
    return 'seja o primeiro';
  }

  void _openComment(String _route) {
    if (_route != PageEnum.HISTORY.value) if (widget._history['isComment']) {
      historyClass.add(widget._history);
      _openModal(context, ModalEnum.COMMENT.value);
    }
  }

  void _openModal(BuildContext context, String modalEnum) {
    showCupertinoModalBottomSheet(
      expand: true,
      context: context,
      barrierColor: UiColor.overlay,
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
        currentUser.value.first.qtyBookmark--;
        toast.toast(
          context,
          ToastEnum.SUCCESS.value,
          'história removida da lista',
        );
      } else {
        history['bookmarks'].add(currentUser.value.first.id);
        currentUser.value.first.qtyBookmark++;
        toast.toast(
          context,
          ToastEnum.SUCCESS.value,
          'história adicionada à lista para ler mais tarde',
        );
      }

      historyFirestore.pathBookmark(history);
    });

    userFirestore.pathQtyBookmarkUser(currentUser.value.first);
  }

  @override
  Widget build(BuildContext context) {
    var _route = ModalRoute.of(context)?.settings.name;

    return Container(
      padding: const EdgeInsets.only(right: UiPadding.medium),
      height: UiSize.historyMenu,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () => _openComment(_route!),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(UiBorder.rounded),
                ),
              ),
              child: Row(
                children: [
                  if (widget._history['qtyComment'] > 0)
                    NumberAnimationWidget(
                      number: widget._history['qtyComment'],
                    ),
                  Text(
                    _textComment(),
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
            ),
            if (_isComment(_route, widget._history))
              ValueListenableBuilder(
                valueListenable: currentUser,
                builder: (BuildContext context, value, __) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                          callback: (value) => historyService.getHistoryPage(
                            widget._history['id'],
                          ),
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
