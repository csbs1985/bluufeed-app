import 'package:bluufeed_app/theme/ui_cor.dart';
import 'package:bluufeed_app/theme/ui_tema.dart';
import 'package:flutter/material.dart';

class SimplesAppbar extends StatefulWidget implements PreferredSizeWidget {
  const SimplesAppbar({super.key});

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
    );
  }
}
