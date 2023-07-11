import 'package:eight_app/config/constant_config.dart';
import 'package:eight_app/modal/enviar_modal.dart';
import 'package:eight_app/text/legenda_text.dart';
import 'package:eight_app/theme/ui_borda.dart';
import 'package:eight_app/theme/ui_cor.dart';
import 'package:eight_app/theme/ui_svg.dart';
import 'package:eight_app/theme/ui_tema.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class EnviarButton extends StatefulWidget {
  const EnviarButton({
    super.key,
    required Map<String, dynamic> historia,
  }) : _historia = historia;

  final Map<String, dynamic> _historia;

  @override
  State<EnviarButton> createState() => _EnviarButtonState();
}

class _EnviarButtonState extends State<EnviarButton> {
  void _abrirModal(BuildContext context) {
    showCupertinoModalBottomSheet(
      context: context,
      barrierColor: UiCor.overlay,
      builder: (context) => EnviarModal(historia: widget._historia),
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
                  UiSvg.enviar,
                  color: isDark ? UiCor.textoEscuro : UiCor.texto,
                );
              },
            ),
            const SizedBox(width: 8),
            const LegendaText(
              legenda: ENVIAR,
            ),
          ],
        ),
      ),
      onTap: () => _abrirModal(context),
    );
  }
}
