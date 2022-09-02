import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_icon.dart';
import 'package:universe_history_app/theme/ui_theme.dart';
import 'package:universe_history_app/widget/button_publish_widget.dart';

class AppbarWidget extends StatefulWidget with PreferredSizeWidget {
  const AppbarWidget({
    Function? callback,
    bool btnBack = false,
    bool btnPublish = false,
  })  : _btnBack = btnBack,
        _btnPublish = btnPublish,
        _callback = callback;

  final bool _btnBack;
  final bool _btnPublish;
  final Function? _callback;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  _AppbarWidgetState createState() => _AppbarWidgetState();
}

class _AppbarWidgetState extends State<AppbarWidget> {
  void _onPressed(BuildContext context) {
    setState(() {
      if (widget._callback != null) widget._callback!(true);
    });
  }

  void _back(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTheme,
      builder: (BuildContext context, Brightness theme, _) {
        bool isDark = currentTheme.value == Brightness.dark;

        return AppBar(
          backgroundColor: isDark ? UiColor.mainDark : UiColor.main,
          elevation: 0,
          leading: IconButton(
            icon: SvgPicture.asset(widget._btnBack ? UiIcon.closed : ''),
            onPressed: () => widget._btnBack ? _back(context) : null,
          ),
          actions: [
            if (widget._btnPublish)
              Center(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: ButtonPublishWidget(
                    callback: (value) => _onPressed(context),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
