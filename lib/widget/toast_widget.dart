import 'package:bluufeed_app/theme/ui_borda.dart';
import 'package:bluufeed_app/theme/ui_cor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class ToastWidget {
  void toast(BuildContext context, ToastEnum? type, String text) {
    Color style = UiCor.primeiro;
    if (type == ToastEnum.SUCESSO.name) {
      style = UiCor.sucesso;
    }

    if (type == ToastEnum.ERRO.name) {
      style = UiCor.alerta;
    }

    showToast(
      text,
      context: context,
      position: StyledToastPosition.center,
      // textStyle: UiTexto.toast,
      backgroundColor: style,
      animation: StyledToastAnimation.slideToBottomFade,
      reverseAnimation: StyledToastAnimation.slideFromBottomFade,
      borderRadius: BorderRadius.circular(UiBorda.arredondada),
    );
  }
}

enum ToastEnum { SUCESSO, ERRO, INFO }
