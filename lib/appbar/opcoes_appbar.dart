import 'package:bluufeed_app/button/icone_button.dart';
import 'package:bluufeed_app/theme/ui_cor.dart';
import 'package:bluufeed_app/theme/ui_svg.dart';
import 'package:bluufeed_app/theme/ui_tema.dart';
import 'package:flutter/material.dart';

class OpcoesAppbar extends StatefulWidget implements PreferredSizeWidget {
  const OpcoesAppbar({
    super.key,
    required Function callback,
  }) : _callback = callback;

  final Function _callback;

  @override
  State<OpcoesAppbar> createState() => _HistoriaAppbarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HistoriaAppbarState extends State<OpcoesAppbar> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTema,
      builder: (BuildContext context, Brightness tema, _) {
        bool isDark = tema == Brightness.dark;

        return AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: isDark ? UiCor.textoEscuro : UiCor.texto,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            IconeButton(
              icone: UiSvg.opcoes,
              cor: isDark ? UiCor.textoEscuro : UiCor.texto,
              callback: () => widget._callback(),
            ),
          ],
        );
      },
    );
  }
}
