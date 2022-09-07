import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_theme.dart';
import 'package:universe_history_app/widget/text_widget.dart';

class ButtonLinkWidget extends StatefulWidget {
  const ButtonLinkWidget({
    required String label,
    required String link,
  })  : _label = label,
        _link = link;

  final String _label;
  final String _link;

  @override
  State<ButtonLinkWidget> createState() => _ButtonLinkWidgetState();
}

class _ButtonLinkWidgetState extends State<ButtonLinkWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTheme,
      builder: (BuildContext context, Brightness theme, _) {
        bool isDark = currentTheme.value == Brightness.dark;

        return Material(
          color: isDark ? UiColor.mainDark : UiColor.main,
          child: SizedBox(
            width: double.infinity,
            height: 48,
            child: GestureDetector(
              child: Container(
                alignment: Alignment.centerLeft,
                child: TextWidget(text: widget._label),
              ),
              onTap: () => context.pushNamed(widget._link),
            ),
          ),
        );
      },
    );
  }
}
