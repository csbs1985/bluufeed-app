import 'package:bluuffed_app/model/comment_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bluuffed_app/firestore/comments_firestore.dart';
import 'package:bluuffed_app/firestore/history_firestore.dart';
import 'package:bluuffed_app/firestore/notifications_firestore.dart';
import 'package:bluuffed_app/firestore/user_firestore.dart';
import 'package:bluuffed_app/model/activity_model.dart';
import 'package:bluuffed_app/model/history_model.dart';
import 'package:bluuffed_app/model/notification_model.dart';
import 'package:bluuffed_app/model/user_model.dart';
import 'package:bluuffed_app/theme/ui_color.dart';
import 'package:bluuffed_app/theme/ui_icon.dart';
import 'package:bluuffed_app/theme/ui_padding.dart';
import 'package:bluuffed_app/theme/ui_size.dart';
import 'package:bluuffed_app/theme/ui_theme.dart';
import 'package:bluuffed_app/widget/border_widget.dart';
import 'package:bluuffed_app/button/button_publish_widget.dart';
import 'package:bluuffed_app/widget/icon_widget.dart';
import 'package:bluuffed_app/widget/text_widget.dart';
import 'package:bluuffed_app/widget/toast_widget.dart';
import 'package:bluuffed_app/widget/toggle_widget.dart';
import 'package:uuid/uuid.dart';

class InputCommentModal extends StatefulWidget {
  const InputCommentModal({super.key});

  @override
  State<InputCommentModal> createState() => _InputCommentModalState();
}

class _InputCommentModalState extends State<InputCommentModal> {
  final TextEditingController _commentController = TextEditingController();

  final ActivityClass activityClass = ActivityClass();
  final CommentClass commentClass = CommentClass();
  final CommentFirestore commentFirestore = CommentFirestore();
  final HistoryFirestore historyFirestore = HistoryFirestore();
  final NotificationClass notificationClass = NotificationClass();
  final NotificationFirestore notificationFirestore = NotificationFirestore();
  final ToastWidget toast = ToastWidget();
  final UserFirestore userFirestore = UserFirestore();
  final Uuid uuid = const Uuid();

  bool _isEdit = false;
  bool _btnPublish = false;
  bool _textSigned = true;

  late Map<String, dynamic> _form;

  @override
  void initState() {
    if (currentComment.value.isNotEmpty) {
      _isEdit = true;
      _btnPublish = true;
      _commentController.text = currentComment.value.first.text;
      _textSigned = currentComment.value.first.isSigned;
    }

    super.initState();
  }

  void keyUp(String _text) {
    setState(() => _btnPublish = _text.isEmpty ? false : true);
  }

  void _clean() {
    if (_commentController.text.isEmpty)
      Navigator.of(context).pop();
    else
      setState(() {
        _commentController.clear();
        _btnPublish = false;
      });
  }

  _toggleAnonimous() => setState(() => _textSigned = !_textSigned);

  Future<void> _postComment(BuildContext context) async {
    _form = {
      'date':
          _isEdit ? currentComment.value.first.date : DateTime.now().toString(),
      'historyId': currentHistory.value.first.id,
      'id': _isEdit ? currentComment.value.first.id : uuid.v4(),
      'isDelete': false,
      'isEdit': _isEdit ? true : false,
      'isSigned': _textSigned,
      'text': _commentController.text.trim(),
      'userId': currentUser.value.first.id,
      'userName': currentUser.value.first.name,
      'userStatus': currentUser.value.first.status
    };

    try {
      await commentFirestore.postComment(_form);
      _pathQtyCommentHistory(context);
    } on FirebaseAuthException catch (error) {
      debugPrint('ERROR => postNewComment: ' + error.toString());
    }
  }

  Future<void> _pathQtyCommentHistory(BuildContext context) async {
    if (!_isEdit) currentHistory.value.first.qtyComment++;

    try {
      await historyFirestore.pathQtyCommentHistory(currentHistory.value.first);
      activityClass.save(
        type: ActivityEnum.NEW_COMMENT.value,
        content: currentHistory.value.first.title,
        elementId: currentHistory.value.first.id,
      );
      _pathQtyCommentUser(context);
    } on FirebaseAuthException catch (error) {
      debugPrint('ERROR => pathQtyCommentHistory: ' + error.toString());
    }
  }

  Future<void> _pathQtyCommentUser(BuildContext context) async {
    if (!_isEdit) currentUser.value.first.qtyComment++;

    try {
      await userFirestore.pathQtyCommentUser(currentUser.value.first);
      _form = {
        'content': currentHistory.value.first.title,
        'date': DateTime.now().toString(),
        'id': uuid.v4(),
        'contentId': currentHistory.value.first.id,
        'userId': currentHistory.value.first.userId,
        'userName': _textSigned ? currentUser.value.first.name : 'anônimo',
        'status': _textSigned
            ? NotificationEnum.COMMENT_SIGNED.value
            : NotificationEnum.COMMENT_ANONYMOUS.value,
        'view': false,
      };

      if (currentUser.value.first.id != currentHistory.value.first.userId) {
        notificationClass.postNotification(context, _form);
        notificationClass.setNotificationOnwer(
          context,
          _form,
          _textSigned,
          _commentController.text,
        );
      }

      if (_isEdit) Navigator.of(context).pop();
      toast.toast(
        context,
        ToastEnum.SUCCESS.value,
        _isEdit
            ? 'Seu comentário foi alterado.'
            : 'Seu comentário foi publicado.',
      );
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (error) {
      debugPrint('ERROR => pathQtyCommentUser: ' + error.toString());
    }
  }

  @override
  void dispose() {
    currentComment.value = [];
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTheme,
      builder: (BuildContext context, Brightness theme, _) {
        bool isDark = currentTheme.value == Brightness.dark;

        return Material(
          color: isDark ? UiColor.mainDark : UiColor.main,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                    bottom:
                        MediaQuery.of(context).viewInsets.bottom + UiSize.input,
                  ),
                  child: TextField(
                    controller: _commentController,
                    autofocus: true,
                    maxLines: null,
                    onChanged: (value) => keyUp(value),
                    style: Theme.of(context).textTheme.headline2,
                    decoration: InputDecoration(
                      fillColor: Colors.transparent,
                      hintMaxLines: 100,
                      hintText:
                          "Escreva seu comentário, ele pode ajudar alguém em um momento difícil, escolha bem as palavras...",
                      hintStyle: Theme.of(context).textTheme.headline2,
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    const BorderWidget(),
                    Container(
                      height: UiSize.input,
                      padding: const EdgeInsets.symmetric(
                        horizontal: UiPadding.large,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconWidget(
                                icon: UiIcon.closed,
                                callback: (value) => _clean(),
                              ),
                              const SizedBox(width: UiPadding.xLarge),
                              ToggleWidget(
                                value: _textSigned,
                                callback: (value) => _toggleAnonimous(),
                              ),
                              const SizedBox(width: UiPadding.medium),
                              TextWidget(
                                text: _textSigned
                                    ? currentUser.value.first.name
                                    : 'anônimo',
                              ),
                            ],
                          ),
                          if (_btnPublish)
                            ButtonPublishWidget(
                              callback: (value) => _postComment(context),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
