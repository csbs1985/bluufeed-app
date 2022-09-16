import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';

class NumberAnimationWidget extends StatelessWidget {
  const NumberAnimationWidget({super.key, required int number})
      : _number = number;

  final int _number;

  @override
  Widget build(BuildContext context) {
    return AnimatedFlipCounter(
      duration: const Duration(milliseconds: 300),
      value: _number,
      textStyle: Theme.of(context).textTheme.headline4,
    );
  }
}
