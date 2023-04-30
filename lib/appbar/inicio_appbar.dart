import 'package:bluufeed_app/class/rotas_class.dart';
import 'package:bluufeed_app/theme/ui_tamanho.dart';
import 'package:bluufeed_app/theme/ui_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class InicioAppbar extends StatelessWidget {
  const InicioAppbar({
    super.key,
    required Function callbackAvatar,
    required Function callbackLogo,
  })  : _callbackAvatar = callbackAvatar,
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
            onTap: () => _callbackLogo,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                icon: SvgPicture.asset(UiSvg.buscar),
                onPressed: () => context.push(RouteEnum.BUSCAR.value),
              ),
              IconButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                icon: SvgPicture.asset(UiSvg.mais),
                onPressed: () => _callbackAvatar,
              ),
            ],
          )
        ],
      ),
    );
  }
}
