import 'package:flutter/material.dart';

class Headline3 extends StatelessWidget {
  const Headline3({required String title}) : _title = title;

  final String _title;

  @override
  Widget build(BuildContext context) {
    return Text(
      _title,
      style: Theme.of(context).textTheme.headline3,
    );
  }
}
