import 'package:flutter/material.dart';
import 'package:universe_history_app/theme/ui_border.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_size.dart';
import 'package:universe_history_app/theme/ui_text.dart';

class Button3dWidget extends StatefulWidget {
  const Button3dWidget({
    required Function callback,
    required String label,
    required String style,
    required String size,
    double? padding = 0,
  })  : _callback = callback,
        _label = label,
        _style = style,
        _size = size,
        _padding = padding;

  final Function _callback;
  final String _label;
  final String _style;
  final String _size;
  final double? _padding;

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
    if (widget._style == ButtonStyleEnum.DISABLED.value) {
      _backColor = UiColor.buttonDisabled;
      _borderColor = UiColor.buttonDisabledBorder;
      _textStyle = UiText.buttonDisabled;
    }
    if (widget._style == ButtonStyleEnum.PRIMARY.value) {
      _backColor = UiColor.button;
      _borderColor = UiColor.buttonBorder;
      _textStyle = UiText.button;
    }
    if (widget._style == ButtonStyleEnum.SECONDARY.value) {
      _backColor = UiColor.buttonSecondary;
      _borderColor = UiColor.buttonSecondaryBorder;
      _textStyle = UiText.buttonSecondary;
    }
  }

  double _getWidth() {
    if (widget._size == ButtonSizeEnum.MEDIUM.value) return 100;
    if (widget._size == ButtonSizeEnum.LARGE.value)
      return MediaQuery.of(context).size.width - widget._padding!;
    return 70;
  }

  double _getHeight() {
    if (widget._size == ButtonSizeEnum.MEDIUM.value ||
        widget._size == ButtonSizeEnum.LARGE.value)
      return UiSize.bottomLarge - UiSize.borderButton;
    return UiSize.bottomSmall - UiSize.borderButton;
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
                height: _getHeight(),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: _backColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(UiBorder.rounded),
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
        if (widget._style != ButtonStyleEnum.DISABLED.value) {
          setState(() {
            _position = UiSize.borderButton;
            widget._callback(true);
          });
        }
      },
      onTapDown: (_) {
        if (widget._style != ButtonStyleEnum.DISABLED.value) {
          setState(() {
            _position = 0;
          });
        }
      },
      onTapCancel: () {
        if (widget._style != ButtonStyleEnum.DISABLED.value) {
          setState(() {
            _position = UiSize.borderButton;
          });
        }
      },
    );
  }
}

enum ButtonStyleEnum {
  DISABLED('disabled'),
  PRIMARY('primart'),
  SECONDARY('secondary');

  final String value;
  const ButtonStyleEnum(this.value);
}

enum ButtonSizeEnum {
  LARGE('large'),
  MEDIUM('medium'),
  SMALL('small');

  final String value;
  const ButtonSizeEnum(this.value);
}
