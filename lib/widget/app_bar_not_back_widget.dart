import 'package:flutter/material.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_theme.dart';

class AppBarNotBackWidget extends StatelessWidget with PreferredSizeWidget {
  const AppBarNotBackWidget({required String title}) : _title = title;

  final String _title;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTheme,
      builder: (BuildContext context, Brightness theme, _) {
        bool isDark = currentTheme.value == Brightness.dark;

        return AppBar(
          backgroundColor: isDark ? UiColor.mainDark : UiColor.main,
          elevation: 0,
          title: Text(
            _title,
            style: Theme.of(context).textTheme.headline1,
          ),
          titleSpacing: 16,
        );
      },
    );
  }
}
