import 'package:flutter/material.dart';

class ButtonPublishWidget extends StatefulWidget {
  const ButtonPublishWidget({required Function callback, String? label})
      : _callback = callback,
        _label = label;

  final Function _callback;
  final String? _label;

  @override
  State<ButtonPublishWidget> createState() => _ButtonPublishWidgetState();
}

class _ButtonPublishWidgetState extends State<ButtonPublishWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        child: Text(widget._label ?? 'publicar'),
        onPressed: () => widget._callback(true),
      ),
    );
  }
}
