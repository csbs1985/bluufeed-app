import 'package:bluufeed_app/button/icone_button.dart';
import 'package:bluufeed_app/class/rotas_class.dart';
import 'package:bluufeed_app/theme/ui_tamanho.dart';
import 'package:bluufeed_app/theme/ui_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class InicioAppbar extends StatelessWidget {
  const InicioAppbar({
    super.key,
    required Function callbackMais,
    required Function callbackLogo,
  })  : _callbackAvatar = callbackMais,
        _callbackLogo = callbackLogo;

  final Function _callbackAvatar;
  final Function _callbackLogo;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: UiTamanho.appbar,
      padding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            child: SvgPicture.asset(UiSvg.identidade),
            onTap: () => _callbackLogo(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconeButton(
                icone: UiSvg.buscar,
                callback: () => context.push(RouteEnum.BUSCAR.value),
              ),
              IconeButton(
                icone: UiSvg.mais,
                callback: () => _callbackAvatar(),
              ),
            ],
          )
        ],
      ),
    );
  }
}
