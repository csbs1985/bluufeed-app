import 'package:flutter/material.dart';

class Headline2 extends StatelessWidget {
  const Headline2({required String text}) : _text = text;

  final String _text;

  @override
  Widget build(BuildContext context) {
    return Text(
      _text,
      style: Theme.of(context).textTheme.headline2,
      textAlign: TextAlign.left,
    );
  }
}
