import 'package:bluufeed_app/button/icone_button.dart';
import 'package:bluufeed_app/class/categoria_class.dart';
import 'package:bluufeed_app/class/comentario_class.dart';
import 'package:bluufeed_app/class/historia_class.dart';
import 'package:bluufeed_app/config/constants_config.dart';
import 'package:bluufeed_app/modal/comentario_modal.dart';
import 'package:bluufeed_app/theme/ui_cor.dart';
import 'package:bluufeed_app/theme/ui_svg.dart';
import 'package:bluufeed_app/theme/ui_tema.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class HistoriaInteracaoWidget extends StatefulWidget {
  const HistoriaInteracaoWidget({
    super.key,
    required Map<String, dynamic> historia,
  }) : _historia = historia;

  final Map<String, dynamic> _historia;

  @override
  State<HistoriaInteracaoWidget> createState() =>
      _HistoriaInteracaoWidgetState();
}

class _HistoriaInteracaoWidgetState extends State<HistoriaInteracaoWidget> {
  final CategoriaClass categoriesClass = CategoriaClass();
  final ComentarioClass _comentarioClass = ComentarioClass();

  @override
  void initState() {
    currentQtdHistoria.value = widget._historia['qtdHistoria'];
    super.initState();
  }

  void _abrirModal(BuildContext context) {
    if (widget._historia['isComentario'])
      showCupertinoModalBottomSheet(
        context: context,
        barrierColor: UiCor.overlay,
        builder: (context) => ComentarioModal(historia: widget._historia),
      );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTema,
      builder: (BuildContext context, Brightness tema, _) {
        bool isDark = tema == Brightness.dark;

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ValueListenableBuilder(
                valueListenable: currentQtdHistoria,
                builder: (BuildContext context, int qtdHistoria, _) {
                  return IconeButton(
                    callback: () => _abrirModal(context),
                    icone: UiSvg.comentario,
                    cor: isDark ? UiCor.textoEscuro : UiCor.texto,
                    texto: _comentarioClass
                        .definirTextoComentario(widget._historia),
                  );
                },
              ),
              IconeButton(
                callback: () => {},
                icone: UiSvg.favorito,
                cor: isDark ? UiCor.textoEscuro : UiCor.texto,
                texto: SALVAR,
              ),
              IconeButton(
                callback: () => {},
                icone: UiSvg.enviar,
                cor: isDark ? UiCor.textoEscuro : UiCor.texto,
                texto: ENVIAR,
              ),
            ],
          ),
        );
      },
    );
  }
}
