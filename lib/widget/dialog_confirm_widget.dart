import 'package:bluuffed_app/button/button_3d_widget.dart';
import 'package:bluuffed_app/theme/ui_border.dart';
import 'package:bluuffed_app/theme/ui_color.dart';
import 'package:bluuffed_app/theme/ui_icon.dart';
import 'package:bluuffed_app/theme/ui_padding.dart';
import 'package:bluuffed_app/theme/ui_theme.dart';
import 'package:bluuffed_app/widget/text_animation_widget.dart';
import 'package:bluuffed_app/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DialogConfirmWidget extends StatefulWidget {
  const DialogConfirmWidget({
    required Function callback,
    required String buttonPrimary,
    required String buttonSecondary,
    required String text,
    required String title,
  })  : _callback = callback,
        _buttonPrimary = buttonPrimary,
        _buttonSecondary = buttonSecondary,
        _text = text,
        _title = title;

  final Function _callback;
  final String _buttonPrimary;
  final String _buttonSecondary;
  final String _text;
  final String _title;

  @override
  State<DialogConfirmWidget> createState() => _DialogConfirmWidgetState();
}

class _DialogConfirmWidgetState extends State<DialogConfirmWidget> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // onWillPop: () async => false,
      onWillPop: null,
      child: ValueListenableBuilder(
        valueListenable: currentTheme,
        builder: (BuildContext context, Brightness theme, _) {
          bool isDark = currentTheme.value == Brightness.dark;

          return AlertDialog(
            backgroundColor: isDark ? UiColor.mainDark : UiColor.main,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(UiBorder.rounded),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(UiIcon.identity),
                const SizedBox(height: UiPadding.large),
                TextAnimationWidget(text: widget._title),
                Headline2(text: widget._text),
                const SizedBox(height: UiPadding.xLarge),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Button3dWidget(
                      callback: (value) => widget._callback(true),
                      label: widget._buttonSecondary,
                      style: ButtonStyleEnum.SECONDARY.value,
                      width: 100,
                    ),
                    Button3dWidget(
                      callback: (value) => widget._callback(false),
                      label: widget._buttonPrimary,
                      style: ButtonStyleEnum.PRIMARY.value,
                      width: 100,
                    )
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
