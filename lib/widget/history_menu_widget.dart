import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:universe_history_app/firestore/histories_firestore.dart';
import 'package:universe_history_app/modal/comment_modal.dart';
import 'package:universe_history_app/model/history_model.dart';
import 'package:universe_history_app/model/page_model.dart';
import 'package:universe_history_app/model/user_model.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_icon.dart';
import 'package:universe_history_app/theme/ui_padding.dart';
import 'package:universe_history_app/theme/ui_size.dart';
import 'package:universe_history_app/widget/icon_widget.dart';
import 'package:universe_history_app/widget/toast_widget.dart';

class HistoryMenuWidget extends StatefulWidget {
  const HistoryMenuWidget({
    required Map<String, dynamic> history,
    required String type,
  })  : _history = history,
        _type = type;

  final Map<String, dynamic> _history;
  final String _type;

  @override
  State<HistoryMenuWidget> createState() => _HistoryMenuWidgetState();
}

class _HistoryMenuWidgetState extends State<HistoryMenuWidget> {
  final HistoriesFirestore historiesFirestore = HistoriesFirestore();
  final HistoryClass historyClass = HistoryClass();
  final ToastWidget toast = ToastWidget();

  bool _getBookmark(history) {
    return history['bookmarks'].contains(currentUser.value.first.id)
        ? true
        : false;
  }

  bool _showBookmark() {
    return currentUser.value.isNotEmpty ? true : false;
  }

  void _selectHistory(history) {
    historyClass.add(history);
  }

  void _showModal(BuildContext context, String type) {
    showCupertinoModalBottomSheet(
      expand: true,
      context: context,
      barrierColor: UiColor.overley,
      duration: const Duration(milliseconds: 300),
      builder: (context) => const CommentModal(),
      // builder: (context) => type == 'inputCommentary'
      //     ? const InputCommmentModal()
      //     : CommentModal(),
    );
  }

  void _showModalOptions(BuildContext context, dynamic content) {
    // historyClass.add(content);

    // showCupertinoModalBottomSheet(
    //   expand: false,
    //   context: context,
    //   barrierColor: Colors.black87,
    //   duration: const Duration(milliseconds: 300),
    //   builder: (context) => OptionsModal(
    //     content['id'],
    //     'história',
    //     content['userId'],
    //     content['userName'],
    //     content['text'],
    //     false,
    //   ),
    // );
  }

  bool _showOpen() {
    return widget._type == 'HOMEPAGE' ? true : false;
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

  String _showComment(history) {
    if (!history['isComment']) return 'comentário desabilitado';
    if (history['qtyComment'] == 1) return ' comentário';
    if (history['qtyComment'] > 1) return ' comentários';
    return 'seja o primeiro a comentar';
  }

  void _openComment(history) {
    if (history['isComment']) {
      _selectHistory(widget._history);

      showCupertinoModalBottomSheet(
        expand: true,
        context: context,
        barrierColor: UiColor.overley,
        duration: const Duration(milliseconds: 300),
        builder: (context) => const CommentModal(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // color: Colors.amber,
      height: UiSize.historyMenu,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => _openComment(widget._history),
            child: Row(
              children: [
                if (widget._history['qtyComment'] > 0)
                  AnimatedFlipCounter(
                    duration: const Duration(milliseconds: 500),
                    value: widget._history['qtyComment'],
                    textStyle: Theme.of(context).textTheme.headline4,
                  ),
                Text(
                  _showComment(widget._history),
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
                  if (widget._history['isComment'])
                    IconWidget(
                      icon: UiIcon.comment,
                      callback: (value) {
                        setState(
                          () {
                            _selectHistory(widget._history);
                            _showModal(context, 'inputCommentary');
                          },
                        );
                      },
                    ),
                  const SizedBox(width: UiPadding.xLarge),
                  if (_showBookmark())
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
                  if (_showOpen())
                    IconWidget(
                      icon: UiIcon.read,
                      callback: (value) {
                        _selectHistory(widget._history);
                        context.push(
                            PageEnum.HISTORY.value + widget._history['id']);
                      },
                    ),
                  const SizedBox(width: UiPadding.xLarge),
                  IconWidget(
                    icon: UiIcon.option,
                    callback: (value) => {
                      _selectHistory(widget._history),
                      _showModalOptions(context, widget._history)
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
