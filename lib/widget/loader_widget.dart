import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:bluuffed_app/core/variables.dart';
import 'package:bluuffed_app/theme/ui_border.dart';
import 'package:bluuffed_app/theme/ui_color.dart';
import 'package:bluuffed_app/theme/ui_padding.dart';
import 'package:bluuffed_app/theme/ui_theme.dart';
import 'package:bluuffed_app/widget/text_widget.dart';

class LoaderWidget extends StatefulWidget {
  const LoaderWidget({Key? key}) : super(key: key);

  @override
  State<LoaderWidget> createState() => _LoaderWidgetState();
}

class _LoaderWidgetState extends State<LoaderWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTheme,
      builder: (BuildContext context, Brightness theme, _) {
        return AlertDialog(
          backgroundColor: UiColor.main,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(UiBorder.rounded),
          ),
          content: SizedBox(
            height: 140,
            child: Column(
              children: [
                LoadingAnimationWidget.newtonCradle(
                  size: 80,
                  color: UiColor.primary,
                ),
                const TextWidget(text: 'Aguarde...'),
                if (currentDialog.value != '')
                  Padding(
                    padding: const EdgeInsets.only(top: UiPadding.medium),
                    child: ValueListenableBuilder(
                      valueListenable: currentDialog,
                      builder: (context, value, __) {
                        return TextWidget(text: currentDialog.value);
                      },
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
