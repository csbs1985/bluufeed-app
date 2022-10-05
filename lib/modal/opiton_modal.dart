import 'package:bluuffed_app/button/option_button.dart';
import 'package:bluuffed_app/firestore/comments_firestore.dart';
import 'package:bluuffed_app/firestore/history_firestore.dart';
import 'package:bluuffed_app/modal/create_page.dart';
import 'package:bluuffed_app/modal/input_comment_modal.dart';
import 'package:bluuffed_app/model/activity_model.dart';
import 'package:bluuffed_app/model/history_model.dart';
import 'package:bluuffed_app/model/modal_model.dart';
import 'package:bluuffed_app/model/page_model.dart';
import 'package:bluuffed_app/model/user_model.dart';
import 'package:bluuffed_app/service/block_service.dart';
import 'package:bluuffed_app/service/comment_service.dart';
import 'package:bluuffed_app/service/following_service.dart';
import 'package:bluuffed_app/service/history_service.dart';
import 'package:bluuffed_app/theme/ui_color.dart';
import 'package:bluuffed_app/theme/ui_icon.dart';
import 'package:bluuffed_app/theme/ui_padding.dart';
import 'package:bluuffed_app/theme/ui_theme.dart';
import 'package:bluuffed_app/widget/dialog_confirm_widget.dart';
import 'package:bluuffed_app/widget/subtitle_resume_widget.dart';
import 'package:bluuffed_app/widget/toast_widget.dart';
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
  final BlockService blockService = BlockService();
  final CommentFirestore commentFirestore = CommentFirestore();
  final CommentService commentService = CommentService();
  final FollowingService followingService = FollowingService();
  final HistoryClass historyClass = HistoryClass();
  final HistoryFirestore historyFirestore = HistoryFirestore();
  final HistoryService historyService = HistoryService();
  final ToastWidget toastWidget = ToastWidget();

  bool canCopy() {
    return (widget._type == ModalEnum.OPTION_COMMENT.value &&
            !widget._content['isDelete'])
        ? true
        : false;
  }

  bool canEdit() {
    if (widget._type == ModalEnum.OPTION_COMMENT.value ||
        widget._type == ModalEnum.OPTION_HISTORY.value) {
      if (widget._content['userId'] == currentUser.value.first.id) {
        if (widget._type == ModalEnum.OPTION_COMMENT.value &&
            !widget._content['isDelete']) return true;
        if (widget._type == ModalEnum.OPTION_HISTORY.value) return true;
      }
    }
    return false;
  }

  bool canDelete() {
    if (widget._type == ModalEnum.OPTION_COMMENT.value ||
        widget._type == ModalEnum.OPTION_HISTORY.value) {
      if (currentHistory.value.first.userId == currentUser.value.first.id ||
          widget._content['userId'] == currentUser.value.first.id) {
        if (widget._type == ModalEnum.OPTION_COMMENT.value &&
            !widget._content['isDelete']) return true;
        if (widget._type == ModalEnum.OPTION_HISTORY.value) return true;
      }
    }
    return false;
  }

  bool canPerfil() {
    if (widget._type == ModalEnum.OPTION_COMMENT.value ||
        widget._type == ModalEnum.OPTION_HISTORY.value) {
      if (widget._content['isSigned'] &&
          currentUser.value.first.id != widget._content['userId']) return true;
    }
    return false;
  }

  bool canBlock() {
    return currentUser.value.first.id != widget._content['userId']
        ? true
        : false;
  }

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
        return widget._type == ModalEnum.OPTION_COMMENT.value
            ? const InputCommentModal()
            : const CreateModal();
      },
    );
  }

  void _delete(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return DialogConfirmWidget(
          title: 'Deletar',
          text: widget._type == ModalEnum.OPTION_COMMENT.value
              ? 'Tem certeza que deseja excluir este comentário?'
              : 'Tem certeza que deseja excluir esta história? Tudo será excluido inclusive os comentátios.',
          buttonPrimary: 'cancelar',
          buttonSecondary: 'deletar',
          callback: (value) => value
              ? widget._type == ModalEnum.OPTION_COMMENT.value
                  ? commentService.deleteComment(context, widget._content)
                  : historyService.deleteHistory(context, widget._content)
              : Navigator.of(context).pop(),
        );
      },
    );
  }

  void _block(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return DialogConfirmWidget(
          title: 'Bloquear usuário',
          text:
              'Tem certeza que deseja bloquear ${widget._content['userName']}? Vocês não poderão ver o conteúdo um do outro.',
          buttonPrimary: 'cancelar',
          buttonSecondary: 'deletar',
          callback: (value) =>
              value ? blockService.bloquear() : Navigator.of(context).pop(),
        );
      },
    );
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
                const SubtitleResumeWidget(
                  title: 'Opções',
                  resume: 'Estas são suas opções',
                ),
                if (canCopy()) const SizedBox(height: UiPadding.medium),
                if (canCopy())
                  OptionButton(
                    label: 'copiar comentário',
                    icon: UiIcon.copy,
                    callback: (value) => _copy(),
                  ),
                if (canEdit()) const SizedBox(height: UiPadding.medium),
                if (canEdit())
                  OptionButton(
                    label: widget._type == ModalEnum.OPTION_COMMENT.value
                        ? 'editar comentário'
                        : 'editar história',
                    icon: UiIcon.edit,
                    callback: (value) => {
                      Navigator.of(context).pop(),
                      _openModal(context),
                    },
                  ),
                if (canDelete()) const SizedBox(height: UiPadding.medium),
                if (canDelete())
                  OptionButton(
                    label: widget._type == ModalEnum.OPTION_COMMENT.value
                        ? 'excluir comentário'
                        : 'excluir história',
                    icon: UiIcon.delete,
                    callback: (value) => {
                      Navigator.of(context).pop(),
                      _delete(context),
                    },
                  ),
                if (canPerfil()) const SizedBox(height: UiPadding.medium),
                if (canPerfil())
                  OptionButton(
                    label: followingService.isFollwingButton(widget._content),
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
                if (canPerfil()) const SizedBox(height: UiPadding.medium),
                if (canPerfil())
                  OptionButton(
                    label: 'ver perfil de ${widget._content['userName']}',
                    icon: UiIcon.perfilActived,
                    callback: (value) => {
                      Navigator.of(context).pop(),
                      Navigator.pushNamed(
                        context,
                        PageEnum.PERFIL.value,
                        arguments: widget._content['userId'],
                      ),
                    },
                  ),
                if (canBlock()) const SizedBox(height: UiPadding.medium),
                if (canBlock())
                  OptionButton(
                    label: widget._content['isSigned']
                        ? 'denunciar ${widget._content['userName']}'
                        : 'denunciar usuário',
                    icon: UiIcon.denounce,
                    callback: (value) => {
                      Navigator.of(context).pop(),
                      currentUserId.value = widget._content['userId'],
                      Navigator.pushNamed(context, PageEnum.DENOUNCE.value),
                    },
                  ),
                if (canBlock()) const SizedBox(height: UiPadding.medium),
                if (canBlock())
                  OptionButton(
                    label: widget._content['isSigned']
                        ? 'bloquear ${widget._content['userName']}'
                        : 'bloquear usuário',
                    icon: UiIcon.block,
                    callback: (value) => _block(context),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
