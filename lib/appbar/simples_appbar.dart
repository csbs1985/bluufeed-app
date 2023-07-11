import 'package:eight_app/button/icone_button.dart';
import 'package:eight_app/theme/ui_cor.dart';
import 'package:eight_app/theme/ui_svg.dart';
import 'package:eight_app/theme/ui_tema.dart';
import 'package:flutter/material.dart';

class SimplesAppbar extends StatefulWidget implements PreferredSizeWidget {
  const SimplesAppbar({
    super.key,
    required Function callback,
  }) : _callback = callback;

  final Function _callback;

  @override
  State<SimplesAppbar> createState() => _HistoriaAppbarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HistoriaAppbarState extends State<SimplesAppbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: ValueListenableBuilder(
            valueListenable: currentTema,
            builder: (BuildContext context, Brightness tema, _) {
              bool isDark = tema == Brightness.dark;

              return Icon(
                Icons.arrow_back,
                color: isDark ? UiCor.textoEscuro : UiCor.texto,
              );
            }),
        onPressed: () => Navigator.of(context).pop(),
      ),
      actions: [
        IconeButton(
          icone: UiSvg.mais,
          callback: () => widget._callback(),
        ),
      ],
    );
  }
}
