import 'package:flutter/material.dart';
import 'package:bluuffed_app/theme/ui_size.dart';
import 'package:bluuffed_app/theme/ui_text.dart';

class ButtonTextWidget extends StatefulWidget {
  const ButtonTextWidget({
    required Function callback,
    required String label,
  })  : _callback = callback,
        _label = label;

  final Function _callback;
  final String _label;

  @override
  State<ButtonTextWidget> createState() => _ButtonTextWidgetState();
}

class _ButtonTextWidgetState extends State<ButtonTextWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        color: Colors.transparent,
        height: UiSize.bottom,
        child: Text(
          widget._label,
          style: UiText.subtitle,
        ),
      ),
      onTap: () => widget._callback(true),
    );
  }
}
