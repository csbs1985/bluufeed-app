import 'package:bluufeed_app/input/padrao_input.dart';
import 'package:bluufeed_app/theme/ui_cor.dart';
import 'package:bluufeed_app/theme/ui_tamanho.dart';
import 'package:bluufeed_app/theme/ui_tema.dart';
import 'package:flutter/material.dart';

class BuscaAppbar extends StatefulWidget implements PreferredSizeWidget {
  const BuscaAppbar({
    super.key,
    required Function callback,
  }) : _callback = callback;

  final Function _callback;

  @override
  State<BuscaAppbar> createState() => _HistoriaAppbarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HistoriaAppbarState extends State<BuscaAppbar> {
  final TextEditingController _buscaController = TextEditingController();

  @override
  void dispose() {
    _buscaController.dispose();
    super.dispose();
  }

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
          title: SizedBox(
              height: UiTamanho.inputTamanho,
              child: PadraoInput(callback: (value) => widget._callback(value))),
        );
      },
    );
  }
}
