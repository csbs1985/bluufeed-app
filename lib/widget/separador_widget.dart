import 'package:bluufeed_app/theme/ui_cor.dart';
import 'package:bluufeed_app/theme/ui_tamanho.dart';
import 'package:bluufeed_app/theme/ui_tema.dart';
import 'package:flutter/cupertino.dart';

class SeparadorWidget extends StatelessWidget {
  const SeparadorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTema,
      builder: (BuildContext context, Brightness tema, _) {
        bool isDark = tema == Brightness.dark;

        return Container(
          color: isDark ? UiCor.bordaEscura : UiCor.borda,
          height: UiTamanho.separador,
        );
      },
    );
  }
}
