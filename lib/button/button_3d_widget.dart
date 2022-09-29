import 'package:bluuffed_app/theme/ui_padding.dart';
import 'package:bluuffed_app/theme/ui_theme.dart';
import 'package:flutter/material.dart';
import 'package:bluuffed_app/theme/ui_border.dart';
import 'package:bluuffed_app/theme/ui_color.dart';
import 'package:bluuffed_app/theme/ui_size.dart';
import 'package:bluuffed_app/theme/ui_text.dart';

class Button3dWidget extends StatefulWidget {
  const Button3dWidget({
    required Function callback,
    required String label,
    required String style,
    double? width,
  })  : _callback = callback,
        _label = label,
        _style = style,
        _width = width;

  final Function _callback;
  final String _label;
  final String _style;

  final double? _width;

  @override
  State<Button3dWidget> createState() => _Button3dWidgetState();
}

class _Button3dWidgetState extends State<Button3dWidget> {
  bool? isDark;

  late double _position = UiSize.borderButton;

  Color _getBackColor() {
    if (widget._style == ButtonStyleEnum.PRIMARY.value) return UiColor.button;
    return isDark! ? UiColor.buttonSecondaryDark : UiColor.buttonSecondary;
  }

  Color _getBorderColor() {
    if (widget._style == ButtonStyleEnum.PRIMARY.value)
      return UiColor.buttonBorder;
    return isDark!
        ? UiColor.buttonSecondaryDarkBorder
        : UiColor.buttonSecondaryBorder;
  }

  TextStyle _getTextStyle() {
    if (widget._style == ButtonStyleEnum.PRIMARY.value) return UiText.button;
    return Theme.of(context).textTheme.headline2!;
  }

  double _getWidth() {
    if (widget._width != null) return widget._width!;
    return MediaQuery.of(context).size.width - UiSize.paddingButtonFull;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: currentTheme,
        builder: (BuildContext context, Brightness theme, _) {
          isDark = currentTheme.value == Brightness.dark;

          return GestureDetector(
            child: SizedBox(
              width: _getWidth(),
              height: UiSize.bottom + UiSize.borderButton,
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: _getWidth(),
                      height: UiSize.bottom,
                      decoration: BoxDecoration(
                        color: _getBorderColor(),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(UiBorder.rounded),
                        ),
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    curve: Curves.easeIn,
                    bottom: _position,
                    duration: const Duration(milliseconds: 10),
                    child: Container(
                      width: _getWidth(),
                      height: UiSize.bottom,
                      padding: const EdgeInsets.symmetric(
                        horizontal: UiPadding.medium,
                      ),
                      decoration: BoxDecoration(
                        color: _getBackColor(),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(UiBorder.rounded),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          widget._label,
                          style: _getTextStyle(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            onTapUp: (_) {
              setState(() {
                _position = UiSize.borderButton;
                widget._callback(true);
              });
            },
            onTapDown: (_) {
              setState(() {
                _position = 0;
              });
            },
            onTapCancel: () {
              setState(() {
                _position = UiSize.borderButton;
              });
            },
          );
        });
  }
}

enum ButtonStyleEnum {
  PRIMARY('primary'),
  SECONDARY('secondary');

  final String value;
  const ButtonStyleEnum(this.value);
}
