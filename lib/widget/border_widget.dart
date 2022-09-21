import 'package:flutter/cupertino.dart';
import 'package:bluuffed_app/theme/ui_color.dart';
import 'package:bluuffed_app/theme/ui_size.dart';
import 'package:bluuffed_app/theme/ui_theme.dart';

class BorderWidget extends StatelessWidget {
  const BorderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTheme,
      builder: (BuildContext context, Brightness theme, _) {
        bool isDark = currentTheme.value == Brightness.dark;

        return Container(
          color: isDark ? UiColor.borderDark : UiColor.border,
          height: UiSize.border,
        );
      },
    );
  }
}
