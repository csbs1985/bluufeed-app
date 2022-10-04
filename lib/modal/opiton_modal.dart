import 'package:bluuffed_app/button/option_button.dart';
import 'package:bluuffed_app/firestore/comments_firestore.dart';
import 'package:bluuffed_app/firestore/history_firestore.dart';
import 'package:bluuffed_app/modal/input_comment_modal.dart';
import 'package:bluuffed_app/model/activity_model.dart';
import 'package:bluuffed_app/model/comment_model.dart';
import 'package:bluuffed_app/model/history_model.dart';
import 'package:bluuffed_app/model/modal_model.dart';
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
import 'package:flutter/services.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class OptionModal extends StatefulWidget {
  const OptionModal({
    required Map<String, dynamic> content,
    required String type,
  })  : _content = content,
        _type = type;

  final Map<String, dynamic> _content;
  final String _type;

  @override
  State<OptionModal> createState() => _OptionModalState();
}

class _OptionModalState extends State<OptionModal> {
  final ActivityClass activityClass = ActivityClass();
  final CommentFirestore commentFirestore = CommentFirestore();
  final FollowingService followingService = FollowingService();
  final HistoryClass historyClass = HistoryClass();
  final HistoryFirestore historyFirestore = HistoryFirestore();
  final ToastWidget toastWidget = ToastWidget();

  bool canCopy() {
    if (widget._type != ModalEnum.OPTION_COMMENT.value) return false;
    return widget._content['isDelete'] ? false : true;
  }

  // bool canEdit() {
  //   if (widget._content['isDelete) return false;
  //   if (currentUser.value.first.id == widget._content['userId)
  //     return true;
  //   if (currentUser.value.first.id == currentHistory.value.first.userId)
  //     return true;
  //   return false;
  // }

  // bool canDelete() {
  //   if (widget._content['isDelete) return false;
  //   if (currentUser.value.first.id == widget._content['userId)
  //     return true;
  //   if (currentUser.value.first.id == currentHistory.value.first.userId)
  //     return true;
  //   return false;
  // }

  // bool canPerfil() {
  //   if (!widget._content['isSigned) return false;
  //   if (currentUser.value.first.id == widget._content['userId)
  //     return false;
  //   return true;
  // }

  void _copy() {
    Clipboard.setData(ClipboardData(text: widget._content['text']));
    toastWidget.toast(
      context,
      ToastEnum.SUCCESS.value,
      'texto copiado!',
    );
    Navigator.of(context).pop();
  }

  void _openModal(BuildContext context) {
    showCupertinoModalBottomSheet(
      expand: true,
      context: context,
      barrierColor: UiColor.overlay,
      duration: const Duration(milliseconds: 300),
      builder: (context) {
        return const InputCommentModal();
      },
    );
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
          .deleteComment(widget._content['id'])
          .then((result) => {
                activityClass.save(
                  type: ActivityEnum.DELETE_COMMENT.value,
                  content: widget._content['text'],
                  elementId: widget._content['userName'],
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
                      'Opções para este comentário escrito por ${currentHistory.value.first.userName}',
                ),
                const SizedBox(height: UiPadding.large),
                if (canCopy())
                  OptionButton(
                    label: 'copiar comentário',
                    icon: UiIcon.copy,
                    callback: (value) => _copy(),
                  ),
                // if (canEdit())
                const SizedBox(height: UiPadding.medium),
                // if (canEdit())
                OptionButton(
                  label: 'editar comentário',
                  icon: UiIcon.edit,
                  callback: (value) => {
                    Navigator.of(context).pop(),
                    _openModal(context),
                  },
                ),
                // if (canDelete())
                const SizedBox(height: UiPadding.medium),
                // if (canDelete())
                OptionButton(
                  label: 'excluir comentário',
                  icon: UiIcon.delete,
                  callback: (value) => {
                    Navigator.of(context).pop(),
                    _delete(context),
                  },
                ),
                // if (canPerfil())
                const SizedBox(height: UiPadding.medium),
                // if (canPerfil())
                OptionButton(
                  label: followingService
                      .isFollwingButton(widget._content['userId']),
                  icon: UiIcon.perfilActived,
                  callback: (value) => {
                    Navigator.of(context).pop(),
                    followingService.toggleFollowing(context, {
                      'id': widget._content['userId'],
                      'name': widget._content['userName'],
                      'date': widget._content['date'],
                    }),
                  },
                ),
                // if (canPerfil())
                const SizedBox(height: UiPadding.medium),
                // if (canPerfil())
                OptionButton(
                  label: 'ver perfil de ${currentHistory.value.first.userName}',
                  icon: UiIcon.perfilActived,
                  callback: (value) => {
                    Navigator.of(context).pop(),
                    currentUserId.value = currentHistory.value.first.userId,
                    Navigator.pushNamed(context, PageEnum.PERFIL.value),
                  },
                ),
                // if (canPerfil())
                const SizedBox(height: UiPadding.medium),
                // if (canPerfil())
                OptionButton(
                  label: 'denunciar ${currentHistory.value.first.userName}',
                  icon: UiIcon.denounce,
                  callback: (value) => {
                    Navigator.of(context).pop(),
                    currentUserId.value = currentHistory.value.first.userId,
                    Navigator.pushNamed(context, PageEnum.DENOUNCE.value),
                  },
                ),
                // if (canPerfil())
                const SizedBox(height: UiPadding.medium),
                // if (canPerfil())
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
