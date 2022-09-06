import 'package:flutter/material.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_text.dart';
import 'package:universe_history_app/theme/ui_theme.dart';

class ButtonTextWidget extends StatefulWidget {
  const ButtonTextWidget({
    required Function callback,
    required String label,
  })  : _callback = callback,
        _label = label;

  final Function _callback;
  final String _label;

  @override
  State<ButtonTextWidget> createState() => _ButtonTextWidgetState();
}

class _ButtonTextWidgetState extends State<ButtonTextWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTheme,
      builder: (BuildContext context, Brightness theme, _) {
        bool isDark = currentTheme.value == Brightness.dark;

        return GestureDetector(
          child: Container(
            color: isDark ? UiColor.mainDark : UiColor.main,
            child: Text(
              widget._label,
              style: UiText.subtitle,
            ),
          ),
          onTap: () => widget._callback(true),
        );
      },
    );
  }
}
