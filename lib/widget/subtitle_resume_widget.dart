import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universe_history_app/theme/ui_text.dart';
import 'package:universe_history_app/theme/ui_theme.dart';
import 'package:universe_history_app/widget/resume_widget.dart';

class SubtitleResumeWidget extends StatelessWidget {
  const SubtitleResumeWidget(
      {required String title, required String resume, double? width})
      : _title = title,
        _resume = resume,
        _width = width;

  final String _title;
  final String _resume;
  final double? _width;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTheme,
      builder: (BuildContext context, Brightness theme, _) {
        bool isDark = currentTheme.value == Brightness.dark;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _title,
              style: isDark ? UiTextDark.headline3 : UiTextLight.headline3,
            ),
            ResumeWidget(
              resume: _resume,
              bottom: 0,
              width: _width,
            ),
          ],
        );
      },
    );
  }
}
