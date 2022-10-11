import 'package:bluuffed_app/button/button_confirm_widget.dart';
import 'package:bluuffed_app/button/button_link_widget.dart';
import 'package:bluuffed_app/text/headline1.dart';
import 'package:bluuffed_app/widget/dialog_confirm_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bluuffed_app/firestore/user_firestore.dart';
import 'package:bluuffed_app/model/page_model.dart';
import 'package:bluuffed_app/model/user_model.dart';
import 'package:bluuffed_app/model/activity_model.dart';
import 'package:bluuffed_app/service/auth_service.dart';
import 'package:bluuffed_app/theme/ui_padding.dart';
import 'package:bluuffed_app/widget/select_toggle_widget.dart';
import 'package:bluuffed_app/widget/separator_widget.dart';
import 'package:bluuffed_app/widget/subtitle_resume_widget.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final ActivityClass activityClass = ActivityClass();
  final AuthService authService = AuthService();
  final UserClass userClass = UserClass();
  final UserFirestore userFirestore = UserFirestore();

  void _toggleNotification() {
    setState(() {
      currentUser.value.first.isNotification =
          !currentUser.value.first.isNotification;

      activityClass.save(
        type: ActivityEnum.UP_NOTIFICATION.value,
        content: currentUser.value.first.id,
        elementId: '',
      );
      _pathNotification();
    });
  }

  Future<void> _pathNotification() async {
    try {
      await userFirestore.pathNotification();
    } on FirebaseAuthException catch (error) {
      debugPrint('ERROR => pathNotification: $error');
    }
  }

  _logout() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return DialogConfirmWidget(
          title: 'Sair',
          buttonPrimary: 'cancelar',
          buttonSecondary: 'sair',
          text:
              'Dar uma tempo e manter seu conteúdo no bluufeed. Sua conta volta a ficar ativa quando entrar novamente com sua conta cadastrada.',
          callback: (value) => goLogout(context, value),
        );
      },
    );
  }

  Future<void> goLogout(BuildContext context, bool _value) async {
    Navigator.pop(context);

    if (_value) userClass.clean(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: Container(),
      ),
      body: SingleChildScrollView(
        child: ValueListenableBuilder(
          valueListenable: currentUser,
          builder: (BuildContext context, value, __) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: UiPadding.large,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Headline1(title: 'Configurações'),
                          const SubtitleResumeWidget(
                            title: 'Conta',
                            resume:
                                'Mantenha seus dados atualizados e consulte seu conteúdo.',
                          ),
                          const SizedBox(height: UiPadding.medium),
                          ButtonLinkWidget(
                            label: 'Nome de usuário',
                            link: PageEnum.NAME.value,
                          ),
                          ButtonLinkWidget(
                            label: 'Biografia',
                            link: PageEnum.NAME.value,
                          ),
                          ButtonLinkWidget(
                            label: 'Senha',
                            link: PageEnum.PASSWORD_EDIT.value,
                          ),
                          ButtonLinkWidget(
                            label: 'Suas atividades',
                            link: PageEnum.ACTIVITY.value,
                          ),
                          ButtonLinkWidget(
                            label: 'Bloqueados',
                            link: PageEnum.ACTIVITY.value,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SeparatorWidget(),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SubtitleResumeWidget(
                        title: 'Informações',
                        resume:
                            'Sobre o bluufeed, perguntas, políticas e termos.',
                      ),
                      const SizedBox(height: UiPadding.medium),
                      const ButtonLinkWidget(label: 'Avaliação', link: '/'),
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
                Padding(
                  padding: const EdgeInsets.all(UiPadding.large),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SubtitleResumeWidget(
                        title: 'Finalizar',
                        resume:
                            'Sair temporariamente ou deletar a conta bluufeed.',
                      ),
                      const SizedBox(height: UiPadding.medium),
                      ButtonConfirmWidget(
                        label: 'Sair',
                        callback: (value) => _logout(),
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
