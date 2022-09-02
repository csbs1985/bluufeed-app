import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:universe_history_app/modal/create_modal.dart';
import 'package:universe_history_app/modal/login_modal.dart';
import 'package:universe_history_app/model/history_model.dart';
import 'package:universe_history_app/model/user_model.dart';
import 'package:universe_history_app/theme/ui_color.dart';
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
  void _pressedButton(BuildContext context) {
    currentHistory.value = [];

    // if (currentUser.value.isEmpty) loginClass.clean();

    showCupertinoModalBottomSheet(
      expand: true,
      context: context,
      barrierColor: UiColor.overley,
      duration: const Duration(milliseconds: 300),
      builder: (context) =>
          currentUser.value.isEmpty ? const LoginWidget() : const CreateModal(),
    );
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
            callback: (value) => _pressedButton(context),
          )
        ],
      ),
    );
  }
}
