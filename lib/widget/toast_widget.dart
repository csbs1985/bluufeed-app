import 'package:eight_app/theme/ui_borda.dart';
import 'package:eight_app/theme/ui_cor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class ToastWidget {
  void toast(
    BuildContext context,
    ToastEnum? type,
    String text,
  ) {
    Color style = UiCor.primeiro;
    if (type == ToastEnum.SUCESSO) style = UiCor.sucesso;
    if (type == ToastEnum.ERRO) style = UiCor.alerta;

    showToast(
      text,
      context: context,
      position: StyledToastPosition.center,
      backgroundColor: style,
      animation: StyledToastAnimation.slideToBottomFade,
      reverseAnimation: StyledToastAnimation.slideFromBottomFade,
      borderRadius: BorderRadius.circular(UiBorda.arredondada),
    );
  }
}

enum ToastEnum { SUCESSO, ERRO, INFO }
