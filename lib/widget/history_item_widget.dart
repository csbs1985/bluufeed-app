import 'package:flutter/cupertino.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_theme.dart';

class HistoryItemWidget extends StatefulWidget {
  const HistoryItemWidget({super.key});

  @override
  State<HistoryItemWidget> createState() => _HistoryItemWidgetState();
}

class _HistoryItemWidgetState extends State<HistoryItemWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTheme,
      builder: (BuildContext context, Brightness theme, _) {
        bool isDark = currentTheme.value == Brightness.dark;

        return Container(
          color: isDark ? UiColor.borderDark : UiColor.border,
          height: 80,
        );
      },
    );
  }
}
