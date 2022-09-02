import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({required String text}) : _text = text;

  final String _text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Text(
        _text,
        style: Theme.of(context).textTheme.headline2,
      ),
    );
  }
}
