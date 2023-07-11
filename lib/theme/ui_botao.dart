import 'package:eight_app/theme/ui_borda.dart';
import 'package:eight_app/theme/ui_cor.dart';
import 'package:flutter/material.dart';

class UiBotao {
  static ButtonStyle buttonDark = ButtonStyle(
    backgroundColor:
        const MaterialStatePropertyAll<Color>(UiCor.botaoSegundoEscuro),
    shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
      RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(UiBorda.circulo)),
    ),
  );

  static ButtonStyle buttonActived = ButtonStyle(
    backgroundColor: const MaterialStatePropertyAll<Color>(UiCor.botao),
    shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
      RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(UiBorda.circulo)),
    ),
  );

  static ButtonStyle tag = ButtonStyle(
    padding: const MaterialStatePropertyAll<EdgeInsets>(
        EdgeInsets.fromLTRB(16, 0, 16, 0)),
    backgroundColor: const MaterialStatePropertyAll<Color>(UiCor.botaoSegundo),
    shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
      RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(UiBorda.circulo)),
    ),
  );

  static ButtonStyle tagEscuro = ButtonStyle(
    padding: const MaterialStatePropertyAll<EdgeInsets>(
        EdgeInsets.fromLTRB(16, 0, 16, 0)),
    backgroundColor:
        const MaterialStatePropertyAll<Color>(UiCor.botaoSegundoEscuro),
    shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
      RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(UiBorda.circulo)),
    ),
  );

  static ButtonStyle tagAtivo = ButtonStyle(
    padding: const MaterialStatePropertyAll<EdgeInsets>(
        EdgeInsets.fromLTRB(16, 0, 16, 0)),
    backgroundColor: const MaterialStatePropertyAll<Color>(UiCor.botao),
    shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
      RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(UiBorda.circulo)),
    ),
  );
}
