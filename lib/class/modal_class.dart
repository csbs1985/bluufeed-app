import 'package:eight_app/theme/ui_cor.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ModalClass {
  void abrirModal(BuildContext context, Function modal) {
    showCupertinoModalBottomSheet(
        expand: true,
        context: context,
        barrierColor: UiCor.overlay,
        duration: const Duration(milliseconds: 300),
        builder: (context) => modal()
        // if (modalEnum == ModalEnum.SEND.value) return const SendModal();
        // if (modalEnum == ModalEnum.INPUT_COMMENT.value) {
        //   return const InputCommentModal();
        // } else {
        //   return const CommentModal();
        // }
        );
  }
}

enum ModalEnum {
  COMMENT('comment'),
  INPUT_COMMENT('input_comment'),
  SEND('send'),
  OPTION_HISTORY('option_history'),
  OPTION_COMMENT('option_comment'),
  OPTION_PERFIL('option_perfil');

  final String value;
  const ModalEnum(this.value);
}
