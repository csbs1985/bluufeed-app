import 'package:flutter/material.dart';

class LabelWidget extends StatelessWidget {
  const LabelWidget({required String label}) : _label = label;

  final String _label;

  @override
  Widget build(BuildContext context) {
    return Text(
      _label,
      style: Theme.of(context).textTheme.headline5,
    );
  }
}
