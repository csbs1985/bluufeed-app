import 'package:bluuffed_app/model/delete_account_model.dart';
import 'package:bluuffed_app/model/page_model.dart';
import 'package:bluuffed_app/model/user_model.dart';
import 'package:bluuffed_app/service/delete_account_service.dart';
import 'package:bluuffed_app/theme/ui_padding.dart';
import 'package:bluuffed_app/theme/ui_theme.dart';
import 'package:bluuffed_app/widget/app_bar_widget_old.dart';
import 'package:bluuffed_app/button/button_card_widget.dart';
import 'package:bluuffed_app/widget/dialog_confirm_widget.dart';
import 'package:bluuffed_app/widget/text_widget.dart';
import 'package:flutter/material.dart';

class DeleteAccountPage extends StatefulWidget {
  const DeleteAccountPage({super.key});

  @override
  State<DeleteAccountPage> createState() => _DeleteAccountPageState();
}

class _DeleteAccountPageState extends State<DeleteAccountPage> {
  final DeleteAccountService deleteAccountService = DeleteAccountService();
  final UserClass userClass = UserClass();

  final List<DeleteAccountModel> _allDeleteAccount =
      DeleteAccountModel.allDeleteAccount;

  void _onPressed(DeleteAccountModel item) {
    if (item.id == '1') return _disableAccount();
    if (item.id == '2') return _routeJustify();
    if (item.id == '3') return _deleteAccount();
    Navigator.of(context).pop();
  }

  void _disableAccount() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return DialogConfirmWidget(
          title: 'Desativar temporariamente',
          buttonPrimary: 'cancelar',
          buttonSecondary: 'desativar',
          text:
              'Dar uma tempo e manter seu conteúdo no bluufeed. Sua conta volta a ficar ativa quando entrar novamente com sua conta cadastrada.',
          callback: (value) =>
              value ? userClass.clean(context) : Navigator.of(context).pop(),
        );
      },
    );
  }

  void _routeJustify() {
    Navigator.of(context).pushNamed(PageEnum.JUSTIFY.value);
  }

  void _deleteAccount() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext buildContext) {
        return DialogConfirmWidget(
          title: 'Deletar conta',
          text:
              'Tem certeza que deseja excluir sua conta bluufeed definitivamente? Você não poderá mais ler, editar e visualizar suas hitórias e comentários. Somente poderá ler as histórias de outros escritores.',
          buttonPrimary: 'cancelar',
          buttonSecondary: 'deletar',
          callback: (value) => value
              ? deleteAccountService.deleteAccount(buildContext, null)
              : Navigator.of(buildContext).pop(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidgetOld(title: 'Deletar conta'),
      body: ValueListenableBuilder(
        valueListenable: currentTheme,
        builder: (BuildContext context, Brightness theme, _) {
          bool isDark = currentTheme.value == Brightness.dark;

          return SingleChildScrollView(
            child: Container(
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
                        'Tem certeza que deseja excluir sua conta bluufeed definitivamente?'
                        '\n'
                        'Você não poderá mais ler, editar e visualizar suas hitórias e comentários. Somente poderá ler as histórias de outros escritores.'
                        '\n\n'
                        'Escolha uma das opções a baixo.',
                  ),
                  const SizedBox(height: UiPadding.large),
                  ButtonCardWidget(
                    content: _allDeleteAccount,
                    callback: (value) => _onPressed(value),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
