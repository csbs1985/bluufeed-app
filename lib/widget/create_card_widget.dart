import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:universe_history_app/modal/create_page.dart';
import 'package:universe_history_app/model/history_model.dart';
import 'package:universe_history_app/model/user_model.dart';
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
  String _user = '';

  void _openCreateModal() {
    currentHistory.value = [];

    showCupertinoModalBottomSheet(
      expand: true,
      context: context,
      barrierColor: Colors.black87,
      duration: const Duration(milliseconds: 300),
      builder: (context) => const CreateModal(),
    );
  }

  @override
  void initState() {
    _user = currentUser.value.isNotEmpty ? currentUser.value.first.name : '';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(UiPadding.large),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleWidget(title: 'Escrever nova história'),
          TextWidget(
            text:
                'O melhor jeito de lembrar é registrando. $_user escreva, conte sua história.',
          ),
          const SizedBox(height: UiPadding.large),
          Button3dWidget(
            label: 'escrever',
            style: ButtonStyleEnum.PRIMARY.value,
            size: ButtonSizeEnum.MEDIUM.value,
            callback: (value) => _openCreateModal(),
          )
        ],
      ),
    );
  }
}
