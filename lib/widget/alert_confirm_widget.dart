import 'package:bluuffed_app/button/button_3d_widget.dart';
import 'package:flutter/material.dart';
import 'package:bluuffed_app/theme/ui_border.dart';
import 'package:bluuffed_app/theme/ui_color.dart';
import 'package:bluuffed_app/theme/ui_padding.dart';
import 'package:bluuffed_app/theme/ui_theme.dart';
import 'package:bluuffed_app/widget/text_widget.dart';

class AlertConfirmWidget extends StatefulWidget {
  const AlertConfirmWidget({
    required Function callback,
    required String title,
    required String text,
    String? btnPrimaryLabel,
    String? btnSecondaryLabel,
  })  : _callback = callback,
        _title = title,
        _text = text,
        _btnPrimaryLabel = btnPrimaryLabel,
        _btnSecondaryLabel = btnSecondaryLabel;

  final Function _callback;
  final String _title;
  final String _text;
  final String? _btnPrimaryLabel;
  final String? _btnSecondaryLabel;

  @override
  State<AlertConfirmWidget> createState() => _AlertConfirmComponentState();
}

class _AlertConfirmComponentState extends State<AlertConfirmWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTheme,
      builder: (BuildContext context, Brightness theme, _) {
        bool isDark = currentTheme.value == Brightness.dark;

        return AlertDialog(
          titlePadding: const EdgeInsets.all(UiPadding.large),
          insetPadding: const EdgeInsets.all(UiPadding.large),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: UiPadding.large),
          actionsPadding: const EdgeInsets.all(UiPadding.large),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(UiBorder.rounded)),
          ),
          backgroundColor: isDark ? UiColor.mainDark : UiColor.main,
          title: Headline2(text: widget._title),
          content: Headline2(text: widget._text),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Button3dWidget(
                  label: widget._btnSecondaryLabel!,
                  style: ButtonStyleEnum.SECONDARY.value,
                  callback: (value) => widget._callback(true),
                ),
                Button3dWidget(
                  label: widget._btnPrimaryLabel!,
                  style: ButtonStyleEnum.PRIMARY.value,
                  callback: (value) => widget._callback(false),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
