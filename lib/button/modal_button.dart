import 'package:bluufeed_app/text/texto_text.dart';
import 'package:bluufeed_app/theme/ui_cor.dart';
import 'package:bluufeed_app/theme/ui_tamanho.dart';
import 'package:bluufeed_app/theme/ui_tema.dart';
import 'package:flutter/material.dart';

class ModalButton extends StatefulWidget {
  const ModalButton({
    super.key,
    required String texto,
    required Function callback,
  })  : _texto = texto,
        _callback = callback;

  final String _texto;
  final Function _callback;

  @override
  State<ModalButton> createState() => _ModalButtonState();
}

class _ModalButtonState extends State<ModalButton> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTema,
      builder: (BuildContext context, Brightness tema, _) {
        bool isDark = tema == Brightness.dark;

        return Material(
          color: isDark ? UiCor.mainEscuro : UiCor.main,
          child: InkWell(
            onTap: () => widget._callback(),
            child: Container(
              height: UiTamanho.appbar,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 16),
              child: TextoText(texto: widget._texto),
            ),
          ),
        );
      },
    );
  }
}
