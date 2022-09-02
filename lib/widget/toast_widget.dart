import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:universe_history_app/theme/ui_border.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_text.dart';

class ToastWidget {
  void toast(BuildContext context, String? type, String text) {
    Color _style = UiColor.primary;

    if (type == ToastEnum.SUCCESS.name)
      _style = UiColor.success;
    else if (type == ToastEnum.WARNING.name)
      _style = UiColor.warning;
    else
      _style = UiColor.primary;

    showToast(
      text,
      context: context,
      position: StyledToastPosition.center,
      textStyle: UiText.toast,
      backgroundColor: _style,
      animation: StyledToastAnimation.slideToBottomFade,
      reverseAnimation: StyledToastAnimation.slideFromBottomFade,
      borderRadius: BorderRadius.circular(UiBorder.rounded),
    );
  }
}

enum ToastEnum { INFO, SUCCESS, WARNING }
