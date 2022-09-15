import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class TextAnimationWidget extends StatelessWidget {
  const TextAnimationWidget({required String text}) : _text = text;

  final String _text;

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      isRepeatingAnimation: true,
      totalRepeatCount: 3,
      animatedTexts: [
        TypewriterAnimatedText(
          _text,
          textStyle: Theme.of(context).textTheme.headline2,
        ),
      ],
    );
  }
}
