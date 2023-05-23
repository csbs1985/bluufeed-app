import 'package:bluufeed_app/modal/comentario_modal.dart';
import 'package:bluufeed_app/text/animado_text.dart';
import 'package:bluufeed_app/theme/ui_borda.dart';
import 'package:bluufeed_app/theme/ui_cor.dart';
import 'package:bluufeed_app/theme/ui_svg.dart';
import 'package:bluufeed_app/theme/ui_tema.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ComentarioButton extends StatefulWidget {
  const ComentarioButton({
    super.key,
    required Map<String, dynamic> historia,
  }) : _historia = historia;

  final Map<String, dynamic> _historia;

  @override
  State<ComentarioButton> createState() => _ComentarioButtonState();
}

class _ComentarioButtonState extends State<ComentarioButton> {
  void _abrirModal(BuildContext context) {
    if (widget._historia['isComentario'])
      showCupertinoModalBottomSheet(
        context: context,
        barrierColor: UiCor.overlay,
        builder: (context) => ComentarioModal(historia: widget._historia),
      );
  }

  void toggleFavorito(BuildContext context, String _idHistoria) {}

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
                  UiSvg.comentario,
                  color: isDark ? UiCor.textoEscuro : UiCor.texto,
                );
              },
            ),
            const SizedBox(width: 8),
            AnimadoText(item: widget._historia),
          ],
        ),
      ),
      onTap: () => _abrirModal(context),
    );
  }
}
