import 'package:flutter/material.dart';

class ButtonPublishWidget extends StatefulWidget {
  const ButtonPublishWidget({
    required Function callback,
  }) : _callback = callback;

  final Function _callback;

  @override
  State<ButtonPublishWidget> createState() => _ButtonPublishWidgetState();
}

class _ButtonPublishWidgetState extends State<ButtonPublishWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        child: const Text('publicar'),
        onPressed: () => widget._callback(true),
      ),
    );
  }
}
