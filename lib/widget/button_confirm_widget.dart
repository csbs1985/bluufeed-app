import 'package:bluuffed_app/theme/ui_color.dart';
import 'package:flutter/material.dart';
import 'package:bluuffed_app/theme/ui_theme.dart';
import 'package:bluuffed_app/widget/text_widget.dart';

class ButtonConfirmWidget extends StatefulWidget {
  const ButtonConfirmWidget({
    required Function callback,
    required String label,
  })  : _callback = callback,
        _label = label;

  final Function _callback;
  final String _label;

  @override
  State<ButtonConfirmWidget> createState() => _ButtonConfirmWidgetState();
}

class _ButtonConfirmWidgetState extends State<ButtonConfirmWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTheme,
      builder: (BuildContext context, Brightness theme, _) {
        bool isDark = currentTheme.value == Brightness.dark;

        return GestureDetector(
          child: Material(
            color: isDark ? UiColor.mainDark : UiColor.main,
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: Container(
                alignment: Alignment.centerLeft,
                child: TextWidget(text: widget._label),
              ),
            ),
          ),
          onTapDown: (TapTop) => widget._callback(true),
        );
      },
    );
  }
}
