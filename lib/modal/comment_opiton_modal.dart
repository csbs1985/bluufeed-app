import 'package:bluuffed_app/button/option_button.dart';
import 'package:bluuffed_app/firestore/comments_firestore.dart';
import 'package:bluuffed_app/firestore/histories_firestore.dart';
import 'package:bluuffed_app/modal/create_page.dart';
import 'package:bluuffed_app/model/activity_model.dart';
import 'package:bluuffed_app/model/history_model.dart';
import 'package:bluuffed_app/model/page_model.dart';
import 'package:bluuffed_app/model/user_model.dart';
import 'package:bluuffed_app/theme/ui_color.dart';
import 'package:bluuffed_app/theme/ui_icon.dart';
import 'package:bluuffed_app/theme/ui_padding.dart';
import 'package:bluuffed_app/theme/ui_theme.dart';
import 'package:bluuffed_app/widget/dialog_confirm_widget.dart';
import 'package:bluuffed_app/widget/subtitle_resume_widget.dart';
import 'package:bluuffed_app/widget/toast_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CommentOptionModal extends StatefulWidget {
  const CommentOptionModal({Key? key}) : super(key: key);

  @override
  State<CommentOptionModal> createState() => _CommentOptionModalState();
}

class _CommentOptionModalState extends State<CommentOptionModal> {
  final ActivityClass activityClass = ActivityClass();
  final CommentFirestore commentFirestore = CommentFirestore();
  final HistoryClass historyClass = HistoryClass();
  final HistoryFirestore historyFirestore = HistoryFirestore();
  final ToastWidget toastWidget = ToastWidget();

  void _copy() {
    // Clipboard.setData(ClipboardData(text: _text));
    // toastWidget.toast(
    //   context,
    //   ToastEnum.SUCCESS.value,
    //   'Texto copiado!',
    // );
    // Navigator.of(context).pop();
  }

  ////////////////////////////////////

  void _openModal(BuildContext context) {
    showCupertinoModalBottomSheet(
      expand: true,
      context: context,
      barrierColor: UiColor.overlay,
      duration: const Duration(milliseconds: 300),
      builder: (context) {
        return const CreateModal();
      },
    );
  }

  void _delete() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return DialogConfirmWidget(
          title: 'Deletar história',
          text:
              'Tem certeza que deseja excluir esta história? Tudo será excluido inclusive os comentátios.',
          buttonPrimary: 'cancelar',
          buttonSecondary: 'excluir',
          callback: (value) =>
              value ? _deleteHistory() : Navigator.of(context).pop(),
        );
      },
    );
  }

  void _deleteHistory() async {
    Navigator.of(context).pop();

    try {
      await historyFirestore
          .deleteHistory(currentHistory.value.first.id)
          .then((result) => {_deleteAllComments()})
          .catchError((error) =>
              debugPrint('ERROR => deleteHistory:' + error.toString()));
      Navigator.of(context).pop();
      toastWidget.toast(
        context,
        ToastEnum.SUCCESS.value,
        'história deletada!',
      );
    } on FirebaseAuthException catch (error) {
      debugPrint('ERROR => deleteComment: ' + error.toString());
    }
  }

  Future<void> _deleteAllComments() async {
    try {
      await commentFirestore
          .getCommentHistory(currentHistory.value.first.id)
          .then((result) async => {
                for (var item in result.docs)
                  await commentFirestore.deleteComment(item.id),
                activityClass.save(
                  type: ActivityEnum.DELETE_HISTORY.value,
                  content: currentHistory.value.first.text,
                  elementId: currentHistory.value.first.userName,
                ),
                Navigator.of(context).pop(),
              });
    } on FirebaseAuthException catch (error) {
      debugPrint('ERROR => deleteAllCommentUser: ' + error.toString());
    }
  }

  bool isAuthor() {
    return currentUser.value.first.id == currentHistory.value.first.userId
        ? true
        : false;
  }

  @override
  void dispose() {
    currentUserId.value = '';
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
                      'Opções para este comentário escrito por ${currentHistory.value.first.userName}',
                ),
                const SizedBox(height: UiPadding.large),
                OptionButton(
                  label: 'copiar comentário',
                  icon: UiIcon.copy,
                  callback: (value) => _copy(),
                ),
                const SizedBox(height: UiPadding.medium),
                // if (isAuthor())
                OptionButton(
                  label: 'editar comentário',
                  icon: UiIcon.edit,
                  callback: (value) => _openModal(context),
                ),
                // if (isAuthor())
                const SizedBox(height: UiPadding.medium),
                // if (isAuthor())
                OptionButton(
                  label: 'excluir comentário',
                  icon: UiIcon.delete,
                  callback: (value) => _delete(),
                ),
                // if (!isAuthor())
                const SizedBox(height: UiPadding.medium),
                // if (!isAuthor())
                OptionButton(
                  label: 'ver perfil de ${currentHistory.value.first.userName}',
                  icon: UiIcon.perfilActived,
                  callback: (value) => {
                    Navigator.of(context).pop(),
                    currentUserId.value = currentHistory.value.first.userId,
                    Navigator.pushNamed(context, PageEnum.PERFIL.value),
                  },
                ),
                const SizedBox(height: UiPadding.medium),
                OptionButton(
                  label: 'denunciar ${currentHistory.value.first.userName}',
                  icon: UiIcon.denounce,
                  callback: (value) => _delete(),
                ),
                const SizedBox(height: UiPadding.medium),
                OptionButton(
                  label: 'bloquear ${currentHistory.value.first.userName}',
                  icon: UiIcon.block,
                  callback: (value) => _delete(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
