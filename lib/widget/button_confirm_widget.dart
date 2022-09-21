import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bluuffed_app/theme/ui_color.dart';
import 'package:bluuffed_app/theme/ui_padding.dart';
import 'package:bluuffed_app/theme/ui_theme.dart';
import 'package:bluuffed_app/widget/alert_confirm_widget.dart';
import 'package:bluuffed_app/widget/text_widget.dart';

class ButtonConfirmWidget extends StatefulWidget {
  const ButtonConfirmWidget({
    required Function callback,
    required String title,
    required String text,
    String? link,
    String? btnPrimaryLabel,
    String? btnSecondaryLabel,
    String? icon,
  })  : _callback = callback,
        _title = title,
        _text = text,
        _btnPrimaryLabel = btnPrimaryLabel,
        _btnSecondaryLabel = btnSecondaryLabel,
        _icon = icon;

  final Function _callback;
  final String _title;
  final String _text;
  final String? _btnPrimaryLabel;
  final String? _btnSecondaryLabel;
  final String? _icon;

  @override
  State<ButtonConfirmWidget> createState() => _ButtonConfirmWidgetState();
}

class _ButtonConfirmWidgetState extends State<ButtonConfirmWidget> {
  Future<Future> _showAlertConfirm() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertConfirmWidget(
          title: widget._title,
          text: widget._text,
          btnPrimaryLabel: widget._btnPrimaryLabel,
          btnSecondaryLabel: widget._btnSecondaryLabel,
          callback: (value) => widget._callback(value),
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

        return Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, UiPadding.medium, 0),
          child: Material(
            color: isDark ? UiColor.mainDark : UiColor.main,
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: widget._icon != null
                  ? TextButton.icon(
                      icon: SvgPicture.asset(widget._icon!),
                      label: Align(
                        alignment: Alignment.centerLeft,
                        child: TextWidget(text: ' ${widget._title}'),
                      ),
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      onPressed: () => _showAlertConfirm(),
                    )
                  : GestureDetector(
                      onTap: () => _showAlertConfirm(),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: TextWidget(text: widget._title),
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}
