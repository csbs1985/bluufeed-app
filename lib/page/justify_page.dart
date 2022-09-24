import 'package:bluuffed_app/model/justtify_model.dart';
import 'package:bluuffed_app/service/delete_account_service.dart';
import 'package:bluuffed_app/theme/ui_padding.dart';
import 'package:bluuffed_app/widget/app_bar_widget.dart';
import 'package:bluuffed_app/button/button_3d_widget.dart';
import 'package:bluuffed_app/button/button_card_widget.dart';
import 'package:bluuffed_app/widget/dialog_confirm_widget.dart';
import 'package:bluuffed_app/widget/text_widget.dart';
import 'package:flutter/material.dart';

class JustifyPage extends StatefulWidget {
  const JustifyPage({Key? key}) : super(key: key);

  @override
  _JustifyPageState createState() => _JustifyPageState();
}

class _JustifyPageState extends State<JustifyPage> {
  final DeleteAccountService deleteAccountService = DeleteAccountService();
  final List<JustifyModel> _allJustify = JustifyModel.allJustify;

  late bool _hasButton;
  JustifyModel? justifySelected;

  @override
  void initState() {
    _hasButton = false;
    super.initState();
  }

  void _selected(JustifyModel item) {
    setState(() {
      _hasButton = true;
      justifySelected = item;
    });
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return DialogConfirmWidget(
          title: 'Justificar e deletar',
          text:
              'Antes me diga o motivo do porque esta deletando sua conta bluufeed.',
          buttonPrimary: 'cancelar',
          buttonSecondary: 'deletar',
          callback: (value) => value
              ? deleteAccountService.deleteAccount(context, justifySelected)
              : Navigator.of(context).pop(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(title: 'Justificar e deletar'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            UiPadding.large,
            0,
            UiPadding.large,
            UiPadding.large,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextWidget(
                text:
                    'Antes me diga o motivo do porque esta deletando sua conta bluufeed.Antes me diga o motivo do porque esta deletando sua conta bluufeed.Antes me diga o motivo do porque esta deletando sua conta bluufeed.Antes me diga o motivo do porque esta deletando sua conta bluufeed.Antes me diga o motivo do porque esta deletando sua conta bluufeed.Antes me diga o motivo do porque esta deletando sua conta bluufeed.Antes me diga o motivo do porque esta deletando sua conta bluufeed.Antes me diga o motivo do porque esta deletando sua conta bluufeed.',
              ),
              const SizedBox(height: UiPadding.large),
              ButtonCardWidget(
                content: _allJustify,
                callback: (value) => _selected(value),
              ),
              const SizedBox(height: UiPadding.large),
              if (_hasButton)
                Button3dWidget(
                  label: 'Justificar e deletar',
                  style: ButtonStyleEnum.PRIMARY.value,
                  size: ButtonSizeEnum.LARGE.value,
                  padding: 32,
                  callback: (value) => _showDialog(context),
                ),
              const SizedBox(height: UiPadding.medium),
            ],
          ),
        ),
      ),
    );
  }
}
