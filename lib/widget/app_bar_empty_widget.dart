import 'package:flutter/material.dart';
import 'package:bluuffed_app/theme/ui_color.dart';
import 'package:bluuffed_app/theme/ui_theme.dart';

class AppBarEmptyWidget extends StatefulWidget with PreferredSizeWidget {
  const AppBarEmptyWidget({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  _AppbarBackWidgetState createState() => _AppbarBackWidgetState();
}

class _AppbarBackWidgetState extends State<AppBarEmptyWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTheme,
      builder: (BuildContext context, Brightness theme, _) {
        bool isDark = currentTheme.value == Brightness.dark;

        return AppBar(
          backgroundColor: isDark ? UiColor.mainDark : UiColor.main,
          elevation: 0,
          titleSpacing: 0,
        );
      },
    );
  }
}
