import 'package:flutter/material.dart';

class LegendaText extends StatelessWidget {
  const LegendaText({
    super.key,
    required String legenda,
  }) : _legenda = legenda;

  final String _legenda;

  @override
  Widget build(BuildContext context) {
    return Text(
      _legenda,
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }
}
