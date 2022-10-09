import 'package:flutter/material.dart';

class Headline6 extends StatelessWidget {
  const Headline6({required String title}) : _title = title;

  final String _title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Text(
        _title,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}
