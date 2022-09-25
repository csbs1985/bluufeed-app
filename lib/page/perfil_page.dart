import 'package:bluuffed_app/button/button_confirm_widget.dart';
import 'package:bluuffed_app/button/button_follow_widget.dart';
import 'package:bluuffed_app/button/button_link_widget.dart';
import 'package:bluuffed_app/model/page_model.dart';
import 'package:bluuffed_app/model/user_model.dart';
import 'package:bluuffed_app/service/date_service.dart';
import 'package:bluuffed_app/text/headline1.dart';
import 'package:bluuffed_app/theme/ui_icon.dart';
import 'package:bluuffed_app/theme/ui_padding.dart';
import 'package:bluuffed_app/theme/ui_theme.dart';
import 'package:bluuffed_app/widget/app_bar_home_widget.dart';
import 'package:bluuffed_app/widget/border_widget.dart';
import 'package:bluuffed_app/widget/card_perfil_widget.dart';
import 'package:bluuffed_app/widget/text_widget.dart';
import 'package:flutter/material.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  final DateService dateService = DateService();
  final UserClass userClass = UserClass();

  late Map<String, dynamic> _date;

  @override
  void initState() {
    // _date = userClass.userModelToMap(currentUser.value.first);
    // // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Map arguments = ModalRoute.of(context)?.settings.arguments as Map;

    return ValueListenableBuilder(
      valueListenable: currentTheme,
      builder: (BuildContext context, Brightness theme, _) {
        bool isDark = currentTheme.value == Brightness.dark;

        return Scaffold(
          appBar: AppBarHomeWidget(callback: (value) {}),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: UiPadding.large),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Headline1(title: 'Perfil'),
                  Text(
                    currentUser.value.first.name,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  TextWidget(text: currentUser.value.first.email),
                  // TextWidget(text: 'desde $_date'),
                  // DateWidget(
                  //   item: _date,
                  //   type: DateEnum.PERFIL.value,
                  // ),
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
          ),
        );
      },
    );
  }
}
