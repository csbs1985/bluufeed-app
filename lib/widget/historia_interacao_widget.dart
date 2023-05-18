import 'package:bluufeed_app/button/icone_button.dart';
import 'package:bluufeed_app/class/categoria_class.dart';
import 'package:bluufeed_app/class/comentario_class.dart';
import 'package:bluufeed_app/class/favorito_class.dart';
import 'package:bluufeed_app/class/historia_class.dart';
import 'package:bluufeed_app/class/usuario_class.dart';
import 'package:bluufeed_app/config/constant_config.dart';
import 'package:bluufeed_app/modal/comentario_modal.dart';
import 'package:bluufeed_app/modal/enviar_modal.dart';
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
  final FavoritoClass _favoritoClass = FavoritoClass();

  @override
  void initState() {
    currentQtdHistoria.value = widget._historia['qtdHistoria'];
    super.initState();
  }

  void _comentarioModal(BuildContext context) {
    if (widget._historia['isComentario'])
      showCupertinoModalBottomSheet(
        context: context,
        barrierColor: UiCor.overlay,
        builder: (context) => ComentarioModal(historia: widget._historia),
      );
  }

  void _enviarModal(BuildContext context) {
    showCupertinoModalBottomSheet(
      context: context,
      barrierColor: UiCor.overlay,
      builder: (context) => EnviarModal(historia: widget._historia),
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
                    callback: () => _comentarioModal(context),
                    icone: UiSvg.comentario,
                    cor: isDark ? UiCor.textoEscuro : UiCor.texto,
                    texto: _comentarioClass
                        .definirTextoComentario(widget._historia),
                  );
                },
              ),
              ValueListenableBuilder(
                valueListenable: currentUsuario,
                builder: (BuildContext context, UsuarioModel usuario, __) {
                  return IconeButton(
                    callback: () => _favoritoClass.toggleFavorito(
                      context,
                      widget._historia['idHistoria'],
                    ),
                    icone: _favoritoClass
                        .isFavoritoIcon(widget._historia['idHistoria']),
                    cor: isDark ? UiCor.textoEscuro : UiCor.texto,
                    texto: SALVAR,
                  );
                },
              ),
              IconeButton(
                callback: () => _enviarModal(context),
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
