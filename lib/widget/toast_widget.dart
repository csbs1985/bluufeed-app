import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:universe_history_app/theme/ui_border.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_text.dart';

class ToastWidget {
  void toast(BuildContext context, String? type, String text) {
    Color style = UiColor.primary;

    if (type == ToastEnum.SUCCESS.value)
      style = UiColor.success;
    else if (type == ToastEnum.WARNING.value)
      style = UiColor.warning;
    else
      style = UiColor.primary;

    showToast(
      text,
      context: context,
      position: StyledToastPosition.center,
      textStyle: UiText.toast,
      backgroundColor: style,
      animation: StyledToastAnimation.slideToBottomFade,
      reverseAnimation: StyledToastAnimation.slideFromBottomFade,
      borderRadius: BorderRadius.circular(UiBorder.rounded),
      animDuration: const Duration(milliseconds: 1),
    );
  }
}

enum ToastEnum {
  INFO('info'),
  SUCCESS('success'),
  WARNING('warning');

  final String value;
  const ToastEnum(this.value);
}
