import 'package:bluufeed_app/button/botao_3d_button.dart';
import 'package:bluufeed_app/class/categoria_class.dart';
import 'package:bluufeed_app/config/constants.dart';
import 'package:bluufeed_app/text/tag_text.dart';
import 'package:bluufeed_app/text/texto_text.dart';
import 'package:bluufeed_app/theme/ui_svg.dart';
import 'package:bluufeed_app/widget/avatar_widget.dart';
import 'package:bluufeed_app/widget/info_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
                padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
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
              IconButton(
                  onPressed: () => {}, icon: SvgPicture.asset(UiSvg.favorito)),
              IconButton(
                  onPressed: () => {}, icon: SvgPicture.asset(UiSvg.enviar)),
              IconButton(
                  onPressed: () => {},
                  icon: SvgPicture.asset(UiSvg.comentario)),
            ],
          )
        ],
      ),
    );
  }
}
