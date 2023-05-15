import 'package:bluufeed_app/button/icone_button.dart';
import 'package:bluufeed_app/class/rotas_class.dart';
import 'package:bluufeed_app/class/usuario_class.dart';
import 'package:bluufeed_app/firestore/notificacao_firestore.dart';
import 'package:bluufeed_app/theme/ui_tamanho.dart';
import 'package:bluufeed_app/theme/ui_svg.dart';
import 'package:bluufeed_app/widget/notificacao_icone_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class InicioAppbar extends StatefulWidget {
  const InicioAppbar({
    super.key,
    required Function callback,
  }) : _callback = callback;

  final Function _callback;

  @override
  State<InicioAppbar> createState() => _InicioAppbarState();
}

class _InicioAppbarState extends State<InicioAppbar> {
  final NotificacaoFirestore _notificacaoFirestore = NotificacaoFirestore();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _notificacaoFirestore.notificacoes.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot>? snapshot) {
        return Container(
          height: UiTamanho.appbar,
          padding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                child: SvgPicture.asset(UiSvg.identidade),
                onTap: () => widget._callback(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconeButton(
                    icone: UiSvg.buscar,
                    callback: () => context.push(RouteEnum.BUSCAR.value),
                  ),
                  Stack(
                    children: [
                      IconeButton(
                        icone: UiSvg.notificacao,
                        callback: () => context.pushNamed(
                          RouteEnum.NOTIFICACAO.value,
                          params: {'idUsuario': currentUsuario.value.idUsuario},
                        ),
                      ),
                      const NotificacaoIconeWidget(),
                    ],
                  ),
                  IconeButton(
                    icone: UiSvg.mais,
                    callback: () => context.pushNamed(RouteEnum.MENU.value,
                        params: {'idUsuario': currentUsuario.value.idUsuario}),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
