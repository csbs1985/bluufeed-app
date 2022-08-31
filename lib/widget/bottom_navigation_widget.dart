import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_icon.dart';
import 'package:universe_history_app/theme/ui_size.dart';
import 'package:universe_history_app/theme/ui_theme.dart';

class BottomNavigationWidget extends StatefulWidget {
  const BottomNavigationWidget({Key? key}) : super(key: key);

  @override
  State<BottomNavigationWidget> createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTheme,
      builder: (BuildContext context, Brightness theme, _) {
        return Container(
          height: UiSize.bottomNavigation,
          width: double.maxFinite,
          decoration: const BoxDecoration(
            border: Border(
              left: BorderSide(
                color: UiColor.border,
                width: UiSize.border,
              ),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: SvgPicture.asset(UiIcon.logo),
                onPressed: () {},
              ),
              IconButton(
                icon: SvgPicture.asset(UiIcon.create),
                onPressed: () {},
              ),
              IconButton(
                icon: SvgPicture.asset(UiIcon.notification),
                onPressed: () {},
              ),
              IconButton(
                icon: SvgPicture.asset(UiIcon.options),
                onPressed: () {},
              ),
            ],
          ),
        );
      },
    );
  }
}
