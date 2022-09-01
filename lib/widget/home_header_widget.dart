import 'package:flutter/material.dart';
import 'package:universe_history_app/theme/ui_padding.dart';
import 'package:universe_history_app/widget/button_3d_widget.dart';

class HomeHeaderWidget extends StatefulWidget {
  const HomeHeaderWidget({Key? key}) : super(key: key);

  @override
  State<HomeHeaderWidget> createState() => _HomeHeaderWidgetState();
}

class _HomeHeaderWidgetState extends State<HomeHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(UiPadding.large),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Criar nova história',
            style: Theme.of(context).textTheme.headline1,
          ),
          const SizedBox(height: UiPadding.medium),
          Text(
            'O melhor jeito de lembrar é registrando. charles.sbs escreva, conte sua história.',
            style: Theme.of(context).textTheme.headline2,
          ),
          const SizedBox(height: UiPadding.large),
          Button3dWidget(
            label: 'escrever',
            style: ButtonStyleEnum.PRIMARY.name,
            size: ButtonSizeEnum.MEDIUM.name,
            callback: () {},
          )
        ],
      ),
    );
  }
}
