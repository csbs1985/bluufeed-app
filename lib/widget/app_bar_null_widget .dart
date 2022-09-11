import 'package:flutter/material.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_theme.dart';
import 'package:universe_history_app/widget/title_widget.dart';

class AppbarNullWidget extends StatefulWidget with PreferredSizeWidget {
  const AppbarNullWidget({String? title}) : _title = title;

  final String? _title;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  _AppbarBackWidgetState createState() => _AppbarBackWidgetState();
}

class _AppbarBackWidgetState extends State<AppbarNullWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTheme,
      builder: (BuildContext context, Brightness theme, _) {
        bool isDark = currentTheme.value == Brightness.dark;

        return AppBar(
          backgroundColor: isDark ? UiColor.mainDark : UiColor.main,
          elevation: 0,
          title: TitleWidget(title: widget._title!),
        );
      },
    );
  }
}
