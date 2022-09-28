import 'package:bluuffed_app/button/button_confirm_widget.dart';
import 'package:bluuffed_app/button/button_follow_widget.dart';
import 'package:bluuffed_app/button/button_link_widget.dart';
import 'package:bluuffed_app/firestore/user_firestore.dart';
import 'package:bluuffed_app/model/page_model.dart';
import 'package:bluuffed_app/model/user_model.dart';
import 'package:bluuffed_app/service/date_service.dart';
import 'package:bluuffed_app/skeleton/perfil_skeleton.dart';
import 'package:bluuffed_app/text/headline1.dart';
import 'package:bluuffed_app/theme/ui_icon.dart';
import 'package:bluuffed_app/theme/ui_padding.dart';
import 'package:bluuffed_app/theme/ui_size.dart';
import 'package:bluuffed_app/theme/ui_theme.dart';
import 'package:bluuffed_app/widget/app_bar_back_widget.dart';
import 'package:bluuffed_app/widget/border_widget.dart';
import 'package:bluuffed_app/widget/card_perfil_widget.dart';
import 'package:bluuffed_app/widget/no_result_widget.dart';
import 'package:bluuffed_app/widget/since_widget.dart';
import 'package:bluuffed_app/widget/text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  final DateService dateService = DateService();
  final UserFirestore userFirestore = UserFirestore();
  final UserClass userClass = UserClass();

  late Map<String, dynamic> _currentPerfil;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTheme,
      builder: (BuildContext context, Brightness theme, _) {
        bool isDark = currentTheme.value == Brightness.dark;

        String _user = currentUserId.value == ''
            ? currentUser.value.first.id
            : currentUserId.value;

        return Scaffold(
          appBar: currentUserId.value == '' ? null : const AppBarBackWidget(),
          body: SingleChildScrollView(
            child: StreamBuilder<QuerySnapshot>(
              stream: userFirestore.getUserId(_user).snapshots(),
              builder: (
                BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot,
              ) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return _noResults();

                  case ConnectionState.waiting:
                    return const PerfilSkeleton();

                  case ConnectionState.done:
                  default:
                    try {
                      _currentPerfil = UserModel.toMap(snapshot.data!.docs[0]);
                      return _perfilItemWidget();
                    } catch (error) {
                      return _noResults();
                    }
                }
              },
            ),
          ),
        );
      },
    );
  }

  Widget _perfilItemWidget() {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: UiPadding.large),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (currentUserId.value == '')
              const SizedBox(height: UiSize.appBar),
            const Headline1(title: 'Perfil'),
            Text(
              _currentPerfil['name'],
              style: Theme.of(context).textTheme.headline6,
            ),
            TextWidget(text: _currentPerfil['email']),
            Row(
              children: [
                const TextWidget(text: 'desde '),
                SinceWidget(date: _currentPerfil['date']),
              ],
            ),
            const SizedBox(height: UiPadding.xLarge),
            const ButtonFollowWidget(),
            const SizedBox(height: UiPadding.xLarge),
            CardPerfilWidget(
              icon: UiIcon.feedActived,
              label: 'histórias',
              number: currentUser.value.first.qtyHistory.toString(),
              link: PageEnum.ABOUT.value,
            ),
            const SizedBox(height: UiPadding.medium),
            CardPerfilWidget(
              icon: UiIcon.feedActived,
              label: 'comentários',
              number: currentUser.value.first.qtyComment.toString(),
              link: '',
            ),
            const SizedBox(height: UiPadding.medium),
            const CardPerfilWidget(
              icon: UiIcon.feedActived,
              label: 'seguindo',
              number: '154',
              link: '',
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: UiPadding.large),
              child: BorderWidget(),
            ),
            ButtonLinkWidget(
              label: 'Nome de usuário',
              link: PageEnum.NAME.value,
            ),
            ButtonLinkWidget(
              label: 'Senha',
              link: PageEnum.PASSWORD_EDIT.value,
            ),
            ButtonConfirmWidget(
              label: 'Sair',
              callback: (value) {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _noResults() {
    return Column(
      children: [
        if (currentUserId.value == '') const SizedBox(height: UiSize.appBar),
        const NoResultWidget(text: 'Não foi possivél encontrar usuário'),
      ],
    );
  }
}
