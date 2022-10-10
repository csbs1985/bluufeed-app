import 'package:bluuffed_app/theme/ui_icon.dart';
import 'package:flutter/material.dart';
import 'package:bluuffed_app/theme/ui_color.dart';
import 'package:bluuffed_app/theme/ui_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBarBackWidget extends StatefulWidget with PreferredSizeWidget {
  AppBarBackWidget({Function? callback, required bool option})
      : _callback = callback,
        _option = option;

  final Function? _callback;
  final bool _option;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  _AppbarBackWidgetState createState() => _AppbarBackWidgetState();
}

class _AppbarBackWidgetState extends State<AppBarBackWidget> {
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
          leading: IconButton(
            icon: SvgPicture.asset(UiIcon.closed),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            if (widget._option)
              IconButton(
                icon: SvgPicture.asset(UiIcon.option),
                onPressed: () => widget._callback!(true),
              ),
          ],
        );
      },
    );
  }
}
