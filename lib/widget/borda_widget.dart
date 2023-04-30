import 'package:bluufeed_app/theme/ui_cor.dart';
import 'package:bluufeed_app/theme/ui_tamanho.dart';
import 'package:bluufeed_app/theme/ui_tema.dart';
import 'package:flutter/cupertino.dart';

class BorderWidget extends StatelessWidget {
  const BorderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTema,
      builder: (BuildContext context, Brightness theme, _) {
        bool isDark = theme == Brightness.dark;

        return Container(
          color: isDark ? UiCor.bordaEscura : UiCor.borda,
          height: UiTamanho.borda,
        );
      },
    );
  }
}
