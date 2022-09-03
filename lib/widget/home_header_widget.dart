import 'package:flutter/material.dart';
import 'package:universe_history_app/model/page_model.dart';
import 'package:universe_history_app/theme/ui_padding.dart';
import 'package:universe_history_app/widget/button_3d_widget.dart';
import 'package:universe_history_app/widget/text_widget.dart';
import 'package:universe_history_app/widget/title_widget.dart';

class HomeHeaderWidget extends StatefulWidget {
  const HomeHeaderWidget({Key? key}) : super(key: key);

  @override
  State<HomeHeaderWidget> createState() => _HomeHeaderWidgetState();
}

class _HomeHeaderWidgetState extends State<HomeHeaderWidget> {
  void onPressed(BuildContext context) {
    Navigator.of(context).pushNamed(PageEnum.CREATE.value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(UiPadding.large),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleWidget(title: 'Criar nova história'),
          const TextWidget(
            text:
                'O melhor jeito de lembrar é registrando. charles.sbs escreva, conte sua história.',
          ),
          const SizedBox(height: UiPadding.large),
          Button3dWidget(
            label: 'escrever',
            style: ButtonStyleEnum.PRIMARY.name,
            size: ButtonSizeEnum.MEDIUM.name,
            callback: (value) => onPressed(context),
          )
        ],
      ),
    );
  }
}
