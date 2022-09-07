import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:universe_history_app/firestore/users_firestore.dart';
import 'package:universe_history_app/model/history_model.dart';
import 'package:universe_history_app/model/page_model.dart';
import 'package:universe_history_app/model/user_model.dart';
import 'package:universe_history_app/model/activity_model.dart';
import 'package:universe_history_app/service/auth_service.dart';
import 'package:universe_history_app/theme/ui_padding.dart';
import 'package:universe_history_app/widget/app_bar_null_widget%20.dart';
import 'package:universe_history_app/widget/button_3d_widget.dart';
import 'package:universe_history_app/widget/button_confirm_widget.dart';
import 'package:universe_history_app/widget/button_link_widget.dart';
import 'package:universe_history_app/widget/select_toggle_widget.dart';
import 'package:universe_history_app/widget/separator_widget.dart';
import 'package:universe_history_app/widget/subtitle_resume_widget.dart';
import 'package:universe_history_app/widget/text_widget.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final ActivityClass activityClass = ActivityClass();
  final UserClass userClass = UserClass();
  final UsersFirestore usersFirestore = UsersFirestore();

  void _login(BuildContext context) {
    currentHistory.value = [];

    // if (currentUser.value.isEmpty) loginClass.clean();

    GoRouter.of(context).push(PageEnum.LOGIN.value);
  }

  void _toggleNotification() {
    setState(() {
      currentUser.value.first.isNotification =
          !currentUser.value.first.isNotification;
      activityClass.save(
        ActivityEnum.UP_NOTIFICATION.name,
        currentUser.value.first.isNotification.toString(),
        '',
      );
      _pathNotification();
    });
  }

  Future<void> _pathNotification() async {
    try {
      await usersFirestore.pathNotification();
    } on AuthException catch (error) {
      debugPrint('ERROR => pathNotification: $error');
    }
  }

  Future<void> goLogout(bool value) async {
    value
        ? userClass.clean(context, UserStatusEnum.INACTIVE.value)
        : Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarNullWidget(),
      body: SingleChildScrollView(
        child: ValueListenableBuilder(
          valueListenable: currentUser,
          builder: (BuildContext context, value, __) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!currentUser.value.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(UiPadding.large),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SubtitleResumeWidget(
                          title: 'Conta',
                          resume:
                              'Você deve ter uma conta Apple ou Google para usar os serviços do History.',
                        ),
                        const SizedBox(height: UiPadding.xLarge),
                        const TextWidget(
                          text: 'Entrar ou criar conta',
                        ),
                        const SizedBox(height: UiPadding.medium),
                        Button3dWidget(
                          label: 'Entrar',
                          size: ButtonSizeEnum.MEDIUM.value,
                          style: ButtonStyleEnum.PRIMARY.value,
                          callback: (value) => _login(context),
                        ),
                      ],
                    ),
                  ),
                if (currentUser.value.isNotEmpty)
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(UiPadding.large),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SubtitleResumeWidget(
                              title: 'Conta',
                              resume:
                                  'Mantenha seus dados atualizados e consulte seu conteúdo.',
                            ),
                            ButtonLinkWidget(
                              label: 'Nome de usuário',
                              link: PageEnum.NAME.value,
                            ),
                            ButtonLinkWidget(
                              label: 'Suas atividades',
                              link: PageEnum.ACTIVITES.value,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                if (currentUser.value.isNotEmpty) const SeparatorWidget(),
                if (currentUser.value.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(UiPadding.large),
                    child: SelectToggleWidget(
                      callback: (value) => _toggleNotification(),
                      title: 'Notificações',
                      resume:
                          'Ligado para habilitar e desligado para desabilitar as notificações.',
                      value: currentUser.value.first.isNotification,
                    ),
                  ),
                const SeparatorWidget(),
                Padding(
                  padding: const EdgeInsets.all(UiPadding.large),
                  child: Column(
                    children: [
                      const SubtitleResumeWidget(
                        title: 'Informações',
                        resume:
                            'Sobre o History, perguntas, políticas e termos.',
                      ),
                      // const ButtonLinkWidget('Avaliação', '/questions'), TODO: adicionar feedback nas lojas de aplicativos.
                      ButtonLinkWidget(
                        label: 'Perguntas frequentes',
                        link: PageEnum.QUESTIONS.value,
                      ),
                      ButtonLinkWidget(
                        label: 'Termo de uso',
                        link: PageEnum.TERMS.value,
                      ),
                      ButtonLinkWidget(
                        label: 'Política de privacidade',
                        link: PageEnum.PRIVACY.value,
                      ),
                      ButtonLinkWidget(
                        label: 'Sobre',
                        link: PageEnum.ABOUT.value,
                      ),
                    ],
                  ),
                ),
                const SeparatorWidget(),
                if (currentUser.value.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(UiPadding.large),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SubtitleResumeWidget(
                          title: 'Finalizar',
                          resume:
                              'Sair temporariamente ou deletar a conta History.',
                        ),
                        ButtonConfirmWidget(
                          title: 'Sair',
                          btnPrimaryLabel: 'Cancelar',
                          btnSecondaryLabel: 'Sair',
                          link: PageEnum.HOME.value,
                          text:
                              'Dar uma tempo e manter seu conteúdo no History. Sua conta volta a ficar ativa quando entrar novamente com sua conta cadastrada.',
                          callback: (value) => goLogout(value),
                        ),
                        ButtonLinkWidget(
                          label: 'Deletar conta',
                          link: PageEnum.DELETE_ACCOUNT.value,
                        ),
                      ],
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
