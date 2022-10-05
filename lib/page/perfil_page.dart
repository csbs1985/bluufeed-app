import 'package:bluuffed_app/button/button_follow_widget.dart';
import 'package:bluuffed_app/firestore/user_firestore.dart';
import 'package:bluuffed_app/model/page_model.dart';
import 'package:bluuffed_app/model/perfil_model.dart';
import 'package:bluuffed_app/model/user_model.dart';
import 'package:bluuffed_app/skeleton/perfil_skeleton.dart';
import 'package:bluuffed_app/text/headline1.dart';
import 'package:bluuffed_app/theme/ui_icon.dart';
import 'package:bluuffed_app/theme/ui_padding.dart';
import 'package:bluuffed_app/theme/ui_size.dart';
import 'package:bluuffed_app/widget/app_bar_back_widget.dart';
import 'package:bluuffed_app/widget/card_perfil_widget.dart';
import 'package:bluuffed_app/widget/no_result_widget.dart';
import 'package:bluuffed_app/widget/separator_widget.dart';
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
  final PerfilClass perfilClass = PerfilClass();
  final UserFirestore userFirestore = UserFirestore();

  late Map<String, dynamic> _perfil;
  late String _user;

  bool isAuthor() {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      _user = ModalRoute.of(context)!.settings.arguments.toString();
      return true;
    }
    _user = currentUser.value.first.id;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isAuthor()
          ? PreferredSize(
              preferredSize: const Size.fromHeight(0),
              child: Container(),
            )
          : const AppBarBackWidget(),
      body: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
          stream: userFirestore.getUserIdSnapshots(_user),
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
                  _perfil = {
                    'id': snapshot.data!.docs[0]['id'],
                    'date': snapshot.data!.docs[0]['date'],
                    'name': snapshot.data!.docs[0]['name'],
                    'upDateName': snapshot.data!.docs[0]['upDateName'],
                    'status': snapshot.data!.docs[0]['status'],
                    'email': snapshot.data!.docs[0]['email'],
                    'token': snapshot.data!.docs[0]['token'],
                    'isNotification': snapshot.data!.docs[0]['isNotification'],
                    'qtyComment': snapshot.data!.docs[0]['qtyComment'],
                    'qtyDenounce': snapshot.data!.docs[0]['qtyDenounce'],
                    'qtyHistory': snapshot.data!.docs[0]['qtyHistory'],
                    'following': snapshot.data!.docs[0]['following'],
                  };

                  return _perfilItemWidget(_perfil);
                } catch (error) {
                  return _noResults();
                }
            }
          },
        ),
      ),
    );
  }

  Widget _perfilItemWidget(Map<String, dynamic> snapshot) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: UiPadding.large),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Headline1(title: snapshot['name']),
              if (isAuthor()) TextWidget(text: snapshot['email']),
              SinceWidget(date: snapshot['date']),
              const SizedBox(height: UiPadding.large),
              if (isAuthor()) ButtonFollowWidget(perfil: _perfil),
            ],
          ),
        ),
        const SizedBox(height: UiPadding.large),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: UiPadding.large),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardPerfilWidget(
                icon: UiIcon.feedActived,
                label: 'histórias',
                number: snapshot['qtyHistory'].toString(),
                link: PageEnum.ABOUT.value,
              ),
              const SizedBox(height: UiPadding.medium),
              CardPerfilWidget(
                icon: UiIcon.feedActived,
                label: 'ler depois',
                number: snapshot['qtyHistory'].toString(),
                link: '',
              ),
              const SizedBox(height: UiPadding.medium),
              CardPerfilWidget(
                icon: UiIcon.feedActived,
                label: 'comentários',
                number: snapshot['qtyComment'].toString(),
                link: '',
              ),
              const SizedBox(height: UiPadding.medium),
              CardPerfilWidget(
                icon: UiIcon.perfilActived,
                label: 'seguindo',
                number: snapshot['following'].length.toString(),
                link: '',
              ),
              if (isAuthor()) const SizedBox(height: UiPadding.medium),
              if (isAuthor())
                CardPerfilWidget(
                  icon: UiIcon.denounce,
                  label: 'denúncias',
                  number: snapshot['qtyDenounce'].toString(),
                  link: '',
                ),
            ],
          ),
        ),
        const SizedBox(height: UiPadding.large),
        const SeparatorWidget(),
      ],
    );
  }

  Widget _noResults() {
    return Column(
      children: [
        if (isAuthor()) const SizedBox(height: UiSize.appBar),
        const NoResultWidget(text: 'Não foi possivél encontrar usuário'),
      ],
    );
  }
}
