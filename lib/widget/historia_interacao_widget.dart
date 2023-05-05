import 'package:bluufeed_app/button/icone_button.dart';
import 'package:bluufeed_app/button/seguir_button.dart';
import 'package:bluufeed_app/class/categoria_class.dart';
import 'package:bluufeed_app/class/comentario_class.dart';
import 'package:bluufeed_app/class/historia_class.dart';
import 'package:bluufeed_app/modal/comentario_modal.dart';
import 'package:bluufeed_app/text/tag_text.dart';
import 'package:bluufeed_app/text/texto_text.dart';
import 'package:bluufeed_app/theme/ui_borda.dart';
import 'package:bluufeed_app/theme/ui_cor.dart';
import 'package:bluufeed_app/theme/ui_svg.dart';
import 'package:bluufeed_app/widget/avatar_widget.dart';
import 'package:bluufeed_app/widget/info_widget.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:go_router/go_router.dart';
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
    showCupertinoModalBottomSheet(
      expand: true,
      context: context,
      barrierColor: UiCor.overlay,
      duration: const Duration(milliseconds: 300),
      builder: (context) => ComentarioModal(historia: widget._historia),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(UiBorda.circulo),
                onTap: () => context.pushNamed('perfil',
                    params: {'idUsuario': widget._historia['idUsuario']}),
                child: Row(
                  children: [
                    const AvatarWidget(size: 16),
                    Container(
                      padding: const EdgeInsets.fromLTRB(8, 8, 24, 8),
                      child: TextoText(texto: widget._historia['nomeUsuario']),
                    ),
                  ],
                ),
              ),
              SeguirButton(idUsuario: widget._historia['idUsuario'])
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: InfoWidget(
              item: widget._historia,
              tipo: InfoEnum.HISTORIA.name,
            ),
          ),
          Wrap(
            children: [
              for (var item in widget._historia['categorias'])
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 4, 0),
                  child: TagText(
                    tag: categoriesClass.pegarTextoCategoria(item),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              IconeButton(
                callback: () => {},
                icone: UiSvg.favorito,
              ),
              IconeButton(
                callback: () => {},
                icone: UiSvg.enviar,
              ),
              if (widget._historia['isComentario'])
                ValueListenableBuilder(
                  valueListenable: currentQtdHistoria,
                  builder: (BuildContext context, int qtdHistoria, _) {
                    return IconeButton(
                      callback: () => _abrirModal(context),
                      icone: UiSvg.comentario,
                      texto: _comentarioClass
                          .definirTextoComentario(widget._historia),
                    );
                  },
                ),
            ],
          )
        ],
      ),
    );
  }
}
