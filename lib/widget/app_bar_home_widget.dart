import 'package:bluuffed_app/theme/ui_color.dart';
import 'package:bluuffed_app/theme/ui_icon.dart';
import 'package:bluuffed_app/theme/ui_padding.dart';
import 'package:bluuffed_app/theme/ui_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBarHomeWidget extends StatefulWidget with PreferredSizeWidget {
  const AppBarHomeWidget({
    required Function callback,
  }) : _callback = callback;

  final Function _callback;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<AppBarHomeWidget> createState() => _AppBarHomeWidgetState();
}

class _AppBarHomeWidgetState extends State<AppBarHomeWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTheme,
      builder: (BuildContext context, Brightness theme, _) {
        bool isDark = currentTheme.value == Brightness.dark;

        return AppBar(
          backgroundColor: isDark ? UiColor.mainDark : UiColor.main,
          elevation: 0,
          leadingWidth: 100,
          leading: IconButton(
            padding: const EdgeInsets.only(left: UiPadding.large),
            icon: SvgPicture.asset(UiIcon.identity),
            onPressed: () => widget._callback(true),
          ),
        );
      },
    );
  }
}
