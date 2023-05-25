import 'package:bluufeed_app/button/icone_button.dart';
import 'package:bluufeed_app/class/notificacao_class.dart';
import 'package:bluufeed_app/class/rotas_class.dart';
import 'package:bluufeed_app/class/usuario_class.dart';
import 'package:bluufeed_app/firestore/notificacao_firestore.dart';
import 'package:bluufeed_app/theme/ui_cor.dart';
import 'package:bluufeed_app/theme/ui_tamanho.dart';
import 'package:bluufeed_app/theme/ui_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

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

  Stream<QuerySnapshot>? _collectionStream;

  @override
  void initState() {
    super.initState();
    _collectionStream = _notificacaoFirestore.notificacoes.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _collectionStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) currentIsNotificacao.value = true;

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
                  ValueListenableBuilder(
                    valueListenable: currentIsNotificacao,
                    builder: (BuildContext context, bool isNotificacao, _) {
                      return RippleAnimation(
                        color: UiCor.terceiro,
                        delay: const Duration(milliseconds: 1000),
                        repeat: true,
                        minRadius: isNotificacao ? 12 : 0,
                        ripplesCount: 8,
                        duration: const Duration(milliseconds: 1 * 1000),
                        child: IconeButton(
                          icone: UiSvg.notificacao,
                          callback: () => context.pushNamed(
                            RouteEnum.NOTIFICACAO.value,
                            params: {
                              'idUsuario': currentUsuario.value.idUsuario
                            },
                          ),
                        ),
                      );
                    },
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
