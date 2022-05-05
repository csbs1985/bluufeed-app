import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:universe_history_app/theme/ui_border.dart';
import 'package:universe_history_app/theme/ui_color.dart';
import 'package:universe_history_app/theme/ui_text_style.dart';

class LoaderComponent extends StatelessWidget {
  const LoaderComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        backgroundColor: uiColor.comp_1,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(uiBorder.rounded)),
        content: SizedBox(
          height: 100,
          child: Column(
            children: [
              LoadingAnimationWidget.newtonCradle(
                  size: 80, color: uiColor.first),
              const Text('Aguarde...', style: uiTextStyle.text1),
            ],
          ),
        ),
      ),
    );
  }
}