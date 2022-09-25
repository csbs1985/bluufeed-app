import 'package:bluuffed_app/theme/ui_icon.dart';
import 'package:flutter/material.dart';
import 'package:bluuffed_app/theme/ui_color.dart';
import 'package:bluuffed_app/theme/ui_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBarWidgetOld extends StatefulWidget with PreferredSizeWidget {
  const AppBarWidgetOld({required String title}) : _title = title;

  final String _title;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  _AppbarBackWidgetState createState() => _AppbarBackWidgetState();
}

class _AppbarBackWidgetState extends State<AppBarWidgetOld> {
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
            widget._title,
            style: Theme.of(context).textTheme.headline6,
          ),
          titleSpacing: 0,
          leading: IconButton(
            icon: SvgPicture.asset(UiIcon.closed),
            onPressed: () => Navigator.of(context).pop(),
          ),
        );
      },
    );
  }
}
