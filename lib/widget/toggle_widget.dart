import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:bluuffed_app/theme/ui_color.dart';
import 'package:bluuffed_app/theme/ui_theme.dart';

class ToggleWidget extends StatefulWidget {
  const ToggleWidget({
    required Function callback,
    required bool value,
  })  : _callback = callback,
        _value = value;

  final Function _callback;
  final bool _value;

  @override
  State<ToggleWidget> createState() => _ToggleWidgetState();
}

class _ToggleWidgetState extends State<ToggleWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTheme,
      builder: (BuildContext context, Brightness theme, _) {
        bool isDark = currentTheme.value == Brightness.dark;

        return FlutterSwitch(
          width: 48,
          height: 32,
          value: widget._value,
          activeColor: UiColor.primary,
          inactiveColor:
              isDark ? UiColor.buttonSecondaryDark : UiColor.buttonSecondary,
          activeToggleColor: UiColor.secondary,
          inactiveToggleColor: UiColor.primary,
          toggleSize: 20,
          onToggle: (value) => widget._callback(value),
        );
      },
    );
  }
}
