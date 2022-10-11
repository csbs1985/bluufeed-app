import 'package:bluuffed_app/theme/ui_border.dart';
import 'package:flutter/material.dart';
import 'package:bluuffed_app/widget/text_widget.dart';

class ButtonConfirmWidget extends StatefulWidget {
  const ButtonConfirmWidget({
    required Function callback,
    required String label,
  })  : _callback = callback,
        _label = label;

  final Function _callback;
  final String _label;

  @override
  State<ButtonConfirmWidget> createState() => _ButtonConfirmWidgetState();
}

class _ButtonConfirmWidgetState extends State<ButtonConfirmWidget> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => widget._callback(true),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(UiBorder.none),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: Container(
          alignment: Alignment.centerLeft,
          child: Headline2(text: widget._label),
        ),
      ),
    );
  }
}
