import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:universe_history_app/model/page_model.dart';
import 'package:universe_history_app/theme/ui_padding.dart';
import 'package:universe_history_app/widget/button_3d_widget.dart';
import 'package:universe_history_app/widget/text_widget.dart';
import 'package:universe_history_app/widget/title_widget.dart';

class CreateCardWidget extends StatefulWidget {
  const CreateCardWidget({Key? key}) : super(key: key);

  @override
  State<CreateCardWidget> createState() => _CreateCardWidgetState();
}

class _CreateCardWidgetState extends State<CreateCardWidget> {
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
            style: ButtonStyleEnum.PRIMARY.value,
            size: ButtonSizeEnum.MEDIUM.value,
            callback: (value) => context.push(PageEnum.CREATE.value),
          )
        ],
      ),
    );
  }
}
