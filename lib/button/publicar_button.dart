import 'package:flutter/material.dart';

class PublicarButton extends StatefulWidget {
  const PublicarButton({super.key, required Function callback, String? texto})
      : _callback = callback,
        _texto = texto;

  final Function _callback;
  final String? _texto;

  @override
  State<PublicarButton> createState() => _PublicarButtonState();
}

class _PublicarButtonState extends State<PublicarButton> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        child: Text(widget._texto ?? 'publicar'),
        onPressed: () => widget._callback(true),
      ),
    );
  }
}
