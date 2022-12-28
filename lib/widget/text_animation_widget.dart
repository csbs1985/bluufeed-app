import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bluuffed_app/theme/ui_color.dart';
import 'package:bluuffed_app/theme/ui_theme.dart';
import 'package:flutter/material.dart';

class TextAnimationWidget extends StatelessWidget {
  const TextAnimationWidget({required String text}) : _text = text;

  final String _text;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTheme,
      builder: (BuildContext context, Brightness theme, _) {
        bool isDark = currentTheme.value == Brightness.dark;

        return AnimatedTextKit(
          isRepeatingAnimation: true,
          totalRepeatCount: 3,
          animatedTexts: [
            TypewriterAnimatedText(
              _text,
              textStyle: isDark
                  ? const TextStyle(color: UiColor.textDark)
                  : const TextStyle(color: UiColor.text),
            ),
          ],
        );
      },
    );
  }
}
