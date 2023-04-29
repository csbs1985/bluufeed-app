import 'package:bluufeed_app/theme/ui_borda.dart';
import 'package:bluufeed_app/theme/ui_cor.dart';
import 'package:flutter/material.dart';

class UiBotao {
  static ButtonStyle button = ButtonStyle(
    backgroundColor: const MaterialStatePropertyAll<Color>(UiCor.botaoSegundo),
    shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
      RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(UiBorda.circulo)),
    ),
  );

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
}