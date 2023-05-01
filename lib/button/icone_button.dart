import 'package:bluufeed_app/text/legenda_text.dart';
import 'package:bluufeed_app/theme/ui_borda.dart';
import 'package:bluufeed_app/theme/ui_cor.dart';
import 'package:bluufeed_app/theme/ui_tema.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconeButton extends StatefulWidget {
  const IconeButton({
    super.key,
    required Function callback,
    String? texto = "",
    required String icon,
  })  : _callback = callback,
        _texto = texto,
        _icon = icon;

  final Function _callback;
  final String? _texto;
  final String _icon;

  @override
  State<IconeButton> createState() => _IconeButtonState();
}

class _IconeButtonState extends State<IconeButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(UiBorda.circulo),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            ValueListenableBuilder(
                valueListenable: currentTema,
                builder: (BuildContext context, Brightness tema, _) {
                  bool isDark = tema == Brightness.dark;
                  return SvgPicture.asset(
                    widget._icon,
                    color: isDark ? UiCor.textoEscuro : UiCor.texto,
                  );
                }),
            if (widget._texto != "") const SizedBox(width: 8),
            if (widget._texto != "") LegendaText(legenda: widget._texto!)
          ],
        ),
      ),
      onTap: () => widget._callback(true),
    );
  }
}
