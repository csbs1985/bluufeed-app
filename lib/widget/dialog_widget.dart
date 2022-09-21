import 'package:bluuffed_app/theme/ui_border.dart';
import 'package:bluuffed_app/theme/ui_color.dart';
import 'package:bluuffed_app/theme/ui_icon.dart';
import 'package:bluuffed_app/theme/ui_padding.dart';
import 'package:bluuffed_app/theme/ui_theme.dart';
import 'package:bluuffed_app/widget/text_animation_widget.dart';
import 'package:bluuffed_app/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

ValueNotifier<String> currentDialog = ValueNotifier<String>('');

class DialogWidget extends StatefulWidget {
  const DialogWidget({super.key});

  @override
  State<DialogWidget> createState() => _DialogWidgetState();
}

class _DialogWidgetState extends State<DialogWidget> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // onWillPop: () async => false,
      onWillPop: null,
      child: ValueListenableBuilder(
        valueListenable: currentTheme,
        builder: (BuildContext context, Brightness theme, _) {
          bool isDark = currentTheme.value == Brightness.dark;

          return AlertDialog(
            backgroundColor: isDark ? UiColor.mainDark : UiColor.main,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(UiBorder.rounded),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(UiIcon.identity),
                const SizedBox(height: UiPadding.large),
                const TextAnimationWidget(text: 'Estamos trabalhando'),
                const TextWidget(
                  text: 'Não feche o aplicativo ou tente mudar de página.',
                ),
                const SizedBox(height: UiPadding.large),
                ValueListenableBuilder(
                  valueListenable: currentDialog,
                  builder: (BuildContext context, String dialog, _) {
                    return TextWidget(text: dialog);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
