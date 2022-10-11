import 'package:bluuffed_app/theme/ui_border.dart';
import 'package:bluuffed_app/theme/ui_color.dart';
import 'package:bluuffed_app/theme/ui_padding.dart';
import 'package:bluuffed_app/theme/ui_theme.dart';
import 'package:bluuffed_app/widget/subtitle_resume_widget.dart';
import 'package:flutter/material.dart';

class PerfilItemWidget extends StatelessWidget {
  const PerfilItemWidget({
    required String title,
    required String resume,
    Function? callback,
  })  : _title = title,
        _resume = resume,
        _callback = callback;

  final String _title;
  final String _resume;
  final Function? _callback;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTheme,
      builder: (BuildContext context, Brightness theme, _) {
        bool isDark = currentTheme.value == Brightness.dark;

        return SizedBox(
          width: MediaQuery.of(context).size.width / 3 - 22,
          child: TextButton(
            onPressed: () => _callback!(true),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(UiPadding.large),
              backgroundColor: isDark
                  ? UiColor.buttonSecondaryDark
                  : UiColor.buttonSecondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(UiBorder.rounded),
              ),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: SubtitleResumeWidget(
                title: _title,
                resume: _resume,
              ),
            ),
          ),
        );
      },
    );
  }
}
