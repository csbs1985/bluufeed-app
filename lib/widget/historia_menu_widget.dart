import 'package:bluufeed_app/class/comentario_class.dart';
import 'package:bluufeed_app/class/favorito_class.dart';
import 'package:bluufeed_app/class/historia_class.dart';
import 'package:bluufeed_app/class/modal_class.dart';
import 'package:bluufeed_app/class/usuario_class.dart';
import 'package:bluufeed_app/text/animado_text.dart';
import 'package:bluufeed_app/text/legenda_text.dart';
import 'package:bluufeed_app/theme/ui_borda.dart';
import 'package:bluufeed_app/theme/ui_espaco.dart';
import 'package:bluufeed_app/theme/ui_svg.dart';
import 'package:bluufeed_app/theme/ui_tamanho.dart';
import 'package:bluufeed_app/button/icone_button.dart';
import 'package:flutter/material.dart';

class HistoriaMenuWidget extends StatefulWidget {
  const HistoriaMenuWidget({
    super.key,
    required Map<String, dynamic> historia,
  }) : _historia = historia;

  final Map<String, dynamic> _historia;

  @override
  State<HistoriaMenuWidget> createState() => _HistoriaMenuWidgetState();
}

class _HistoriaMenuWidgetState extends State<HistoriaMenuWidget> {
  final ComentarioClass _comentarioClass = ComentarioClass();
  final FavoritoClass _favoritoClass = FavoritoClass();
  final HistoriaClass _historiaClass = HistoriaClass();
  final ModalClass _modalClass = ModalClass();

  @override
  Widget build(BuildContext context) {
    var _route = ModalRoute.of(context)?.settings.name;

    return Container(
      padding: const EdgeInsets.only(right: UiEspaco.medium),
      height: UiTamalho.historiaMenuAltura,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () => _comentarioClass.abrirComentario(
                  context, _route!, widget._historia),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(UiBorda.arredondada),
                ),
              ),
              child: Row(
                children: [
                  if (widget._historia['qtdComentario'] > 0)
                    AnimadoText(
                      texto: widget._historia['qtdComentario'],
                    ),
                  LegendaText(
                    legenda:
                        _historiaClass.definirTextoComentario(widget._historia),
                  ),
                ],
              ),
            ),
            if (_historiaClass.isComentario(_route, widget._historia))
              ValueListenableBuilder(
                valueListenable: currentUsuario,
                builder: (BuildContext context, value, __) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconeButton(
                        icon: UiSvg.comentario,
                        callback: (value) {
                          _historiaClass.adicionar(widget._historia);
                          // _modalClass.abrirModal(
                          //     context, InputCommentModal());
                        },
                      ),
                      const SizedBox(width: UiEspaco.xLarge),
                      ValueListenableBuilder(
                        valueListenable: currentHistoria,
                        builder: (BuildContext context, value, __) {
                          return IconeButton(
                            icon: _favoritoClass.isFavorito(widget._historia),
                            callback: (value) {
                              _favoritoClass.toggleFavorito(
                                  context, widget._historia);
                            },
                          );
                        },
                      ),
                      const SizedBox(width: UiEspaco.xLarge),
                      IconeButton(
                        icon: UiSvg.enviar,
                        callback: (value) {
                          _historiaClass.adicionar(widget._historia);
                          // _modalClass.abrirModal(context, ModalEnum.SEND.value);
                        },
                      ),
                    ],
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
