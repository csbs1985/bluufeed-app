import 'package:bluufeed_app/theme/ui_cor.dart';
import 'package:bluufeed_app/theme/ui_tema.dart';
import 'package:flutter/material.dart';

class VoltarAppbar extends StatefulWidget implements PreferredSizeWidget {
  const VoltarAppbar({super.key});

  @override
  State<VoltarAppbar> createState() => _HistoriaAppbarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HistoriaAppbarState extends State<VoltarAppbar> {
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
