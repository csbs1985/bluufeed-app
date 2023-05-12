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
    required Function callbackMais,
    required Function callbackLogo,
  })  : _callbackAvatar = callbackMais,
        _callbackLogo = callbackLogo;

  final Function _callbackAvatar;
  final Function _callbackLogo;

  @override
  State<InicioAppbar> createState() => _InicioAppbarState();
}

class _InicioAppbarState extends State<InicioAppbar> {
  final NotificacaoFirestore _notificacaoFirestore = NotificacaoFirestore();

  final int _quantidadeNotificacao = 0;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _notificacaoFirestore.notificacao.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot>? snapshot) {
        if (snapshot!.data!.docs.isNotEmpty) {
          currentNotificacao.value = true;
        }

        return Container(
          height: UiTamanho.appbar,
          padding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                child: SvgPicture.asset(UiSvg.identidade),
                onTap: () => widget._callbackLogo(),
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
                          'notificacao',
                          params: {'idUsuario': currentUsuario.value.idUsuario},
                        ),
                      ),
                      if (currentNotificacao.value)
                        const Positioned(
                          top: 10,
                          right: 10,
                          child: RippleAnimation(
                            color: UiCor.alerta,
                            delay: Duration(milliseconds: 500),
                            repeat: true,
                            minRadius: 8,
                            ripplesCount: 3,
                            duration: Duration(milliseconds: 3 * 500),
                            child: CircleAvatar(
                              minRadius: 4,
                              maxRadius: 4,
                              backgroundColor: UiCor.alerta,
                            ),
                          ),
                        ),
                    ],
                  ),
                  IconeButton(
                    icone: UiSvg.mais,
                    callback: () => widget._callbackAvatar(),
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
