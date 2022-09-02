import 'package:flutter/material.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_size.dart';
import 'package:universe_history_app/theme/ui_text.dart';

class Button3dWidget extends StatefulWidget {
  const Button3dWidget({
    required Function callback,
    required String label,
    required String style,
    required String size,
  })  : _callback = callback,
        _label = label,
        _style = style,
        _size = size;

  final Function _callback;
  final String _label;
  final String _style;
  final String _size;

  @override
  State<Button3dWidget> createState() => _Button3dWidgetState();
}

class _Button3dWidgetState extends State<Button3dWidget> {
  Color _backColor = UiColor.primary;
  Color _borderColor = UiColor.secondary;

  TextStyle _textStyle = UiText.button;

  late double _position = UiSize.borderButton;

  @override
  initState() {
    _getStyle();
    super.initState();
  }

  void _getStyle() {
    if (widget._style == ButtonStyleEnum.PRIMARY.name) {
      _backColor = UiColor.button;
      _borderColor = UiColor.buttonBorder;
      _textStyle = UiText.button;
    }
    if (widget._style == ButtonStyleEnum.SECONDARY.name) {
      _backColor = UiColor.buttonSecondary;
      _borderColor = UiColor.buttonSecondaryBorder;
      _textStyle = UiText.buttonSecondary;
    }
    if (widget._style == ButtonStyleEnum.DISABLED.name) {
      _backColor = UiColor.buttonDisabled;
      _borderColor = UiColor.buttonDisabledBorder;
      _textStyle = UiText.buttonDisabled;
    }
  }

  double _getWidth() {
    if (widget._size == ButtonSizeEnum.MEDIUM.name) return 100;
    if (widget._size == ButtonSizeEnum.LARGE.name)
      return MediaQuery.of(context).size.width - UiSize.widthFullLessPadding;
    return 70;
  }

  double _getHeight() {
    if (widget._size == ButtonSizeEnum.MEDIUM.name ||
        widget._size == ButtonSizeEnum.LARGE.name)
      return 42 - UiSize.borderButton;
    return 32 - UiSize.borderButton;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SizedBox(
        width: _getWidth(),
        height: _getHeight() + UiSize.borderButton,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: Container(
                width: _getWidth(),
                height: _getHeight(),
                decoration: BoxDecoration(
                  color: _borderColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
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
                height: _getHeight(),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: _backColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: Center(
                  child: Text(
                    widget._label,
                    style: _textStyle,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      onTapUp: (_) {
        if (widget._style != ButtonStyleEnum.DISABLED.name) {
          setState(() {
            _position = UiSize.borderButton;
            widget._callback(true);
          });
        }
      },
      onTapDown: (_) {
        if (widget._style != ButtonStyleEnum.DISABLED.name) {
          setState(() {
            _position = 0;
          });
        }
      },
      onTapCancel: () {
        if (widget._style != ButtonStyleEnum.DISABLED.name) {
          setState(() {
            _position = UiSize.borderButton;
          });
        }
      },
    );
  }
}

enum ButtonStyleEnum { DISABLED, SECONDARY, PRIMARY }
enum ButtonSizeEnum { LARGE, MEDIUM, SMALL }
