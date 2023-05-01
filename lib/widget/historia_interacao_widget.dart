import 'package:bluufeed_app/button/botao_3d_button.dart';
import 'package:bluufeed_app/button/icone_button.dart';
import 'package:bluufeed_app/class/categoria_class.dart';
import 'package:bluufeed_app/class/historia_class.dart';
import 'package:bluufeed_app/config/constants.dart';
import 'package:bluufeed_app/modal/comentario_modal.dart';
import 'package:bluufeed_app/text/tag_text.dart';
import 'package:bluufeed_app/text/texto_text.dart';
import 'package:bluufeed_app/theme/ui_cor.dart';
import 'package:bluufeed_app/theme/ui_svg.dart';
import 'package:bluufeed_app/widget/avatar_widget.dart';
import 'package:bluufeed_app/widget/info_widget.dart';
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
  final HistoriaClass _historiaClass = HistoriaClass();

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
      padding: const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const AvatarWidget(size: 16),
              Container(
                padding: const EdgeInsets.fromLTRB(8, 8, 24, 8),
                child: TextoText(texto: widget._historia['nomeUsuario']),
              ),
              Botao3dButton(
                callback: () => {},
                texto: SEGUIR,
                largura: 80,
              )
            ],
          ),
          InfoWidget(
            item: widget._historia,
            avatar: false,
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
          Row(
            children: [
              IconeButton(
                callback: (value) => {},
                icon: UiSvg.favorito,
              ),
              IconeButton(
                callback: (value) => {},
                icon: UiSvg.enviar,
              ),
              IconeButton(
                callback: (value) => _abrirModal(context),
                icon: UiSvg.comentario,
                texto: _historiaClass.definirTextoComentario(widget._historia),
              ),
            ],
          )
        ],
      ),
    );
  }
}
