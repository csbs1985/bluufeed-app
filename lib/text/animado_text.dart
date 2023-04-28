import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';

class AnimadoText extends StatelessWidget {
  const AnimadoText({
    super.key,
    required int texto,
  }) : _texto = texto;

  final int _texto;

  @override
  Widget build(BuildContext context) {
    return AnimatedFlipCounter(
      duration: const Duration(milliseconds: 300),
      value: _texto,
      textStyle: Theme.of(context).textTheme.headlineSmall,
    );
  }
}
