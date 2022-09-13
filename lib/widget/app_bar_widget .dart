import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_icon.dart';
import 'package:universe_history_app/theme/ui_theme.dart';

class AppbarWidget extends StatefulWidget with PreferredSizeWidget {
  const AppbarWidget({bool? isBack = false, String? title})
      : _isBack = isBack,
        _title = title;

  final bool? _isBack;
  final String? _title;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  _AppbarBackWidgetState createState() => _AppbarBackWidgetState();
}

class _AppbarBackWidgetState extends State<AppbarWidget> {
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
            widget._title!,
            style: Theme.of(context).textTheme.headline1,
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
