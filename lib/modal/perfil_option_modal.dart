import 'package:bluuffed_app/button/option_button.dart';
import 'package:bluuffed_app/firestore/comments_firestore.dart';
import 'package:bluuffed_app/firestore/history_firestore.dart';
import 'package:bluuffed_app/model/activity_model.dart';
import 'package:bluuffed_app/model/comment_model.dart';
import 'package:bluuffed_app/model/history_model.dart';
import 'package:bluuffed_app/model/page_model.dart';
import 'package:bluuffed_app/model/user_model.dart';
import 'package:bluuffed_app/service/following_service.dart';
import 'package:bluuffed_app/theme/ui_color.dart';
import 'package:bluuffed_app/theme/ui_icon.dart';
import 'package:bluuffed_app/theme/ui_padding.dart';
import 'package:bluuffed_app/theme/ui_theme.dart';
import 'package:bluuffed_app/widget/dialog_confirm_widget.dart';
import 'package:bluuffed_app/widget/subtitle_resume_widget.dart';
import 'package:bluuffed_app/widget/toast_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PerfilOptionModal extends StatefulWidget {
  const PerfilOptionModal({Key? key}) : super(key: key);

  @override
  State<PerfilOptionModal> createState() => _PerfilOptionModalState();
}

class _PerfilOptionModalState extends State<PerfilOptionModal> {
  final ActivityClass activityClass = ActivityClass();
  final CommentFirestore commentFirestore = CommentFirestore();
  final FollowingService followingService = FollowingService();
  final HistoryClass historyClass = HistoryClass();
  final HistoryFirestore historyFirestore = HistoryFirestore();
  final ToastWidget toastWidget = ToastWidget();

  bool canDelete() {
    if (currentComment.value.first.isDelete) return false;
    if (currentUser.value.first.id == currentComment.value.first.userId)
      return true;
    if (currentUser.value.first.id == currentHistory.value.first.userId)
      return true;
    return false;
  }

  bool canPerfil() {
    if (!currentComment.value.first.isSigned) return false;
    if (currentUser.value.first.id == currentComment.value.first.userId)
      return false;
    return true;
  }

  void _delete(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return DialogConfirmWidget(
          title: 'Deletar comentário',
          text: 'Tem certeza que deseja excluir este comentário?',
          buttonPrimary: 'cancelar',
          buttonSecondary: 'deletar',
          callback: (value) =>
              value ? _deleteComment() : Navigator.of(context).pop(),
        );
      },
    );
  }

  void _deleteComment() async {
    Navigator.of(context).pop();

    try {
      await commentFirestore
          .deleteComment(currentComment.value.first.id)
          .then((result) => {
                activityClass.save(
                  type: ActivityEnum.DELETE_COMMENT.value,
                  content: currentComment.value.first.text,
                  elementId: currentComment.value.first.userName,
                ),
              })
          .catchError((error) =>
              debugPrint('ERROR => deleteHistory:' + error.toString()));
      Navigator.of(context).pop();
      toastWidget.toast(
        context,
        ToastEnum.SUCCESS.value,
        'comentário deletado!',
      );
    } on FirebaseAuthException catch (error) {
      debugPrint('ERROR => deleteComment: ' + error.toString());
    }
  }

  @override
  void dispose() {
    currentUserId.value = '';
    currentComment.value = [];
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
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(UiPadding.large),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SubtitleResumeWidget(
                  title: 'Opções',
                  resume:
                      'Opções para o usuário ${currentHistory.value.first.userName}',
                ),
                const SizedBox(height: UiPadding.large),
                const SizedBox(height: UiPadding.medium),
                OptionButton(
                  label: 'denunciar ${currentHistory.value.first.userName}',
                  icon: UiIcon.denounce,
                  callback: (value) => {
                    Navigator.of(context).pop(),
                    currentUserId.value = currentHistory.value.first.userId,
                    Navigator.pushNamed(context, PageEnum.DENOUNCE.value),
                  },
                ),
                const SizedBox(height: UiPadding.medium),
                OptionButton(
                  label: 'bloquear ${currentHistory.value.first.userName}',
                  icon: UiIcon.block,
                  callback: (value) => _delete(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
