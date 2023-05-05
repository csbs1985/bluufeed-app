import 'package:bluufeed_app/class/usuario_class.dart';
import 'package:bluufeed_app/config/constants_config.dart';
import 'package:bluufeed_app/text/texto_text.dart';
import 'package:bluufeed_app/theme/ui_borda.dart';
import 'package:bluufeed_app/theme/ui_cor.dart';
import 'package:bluufeed_app/theme/ui_espaco.dart';
import 'package:bluufeed_app/theme/ui_tema.dart';
import 'package:bluufeed_app/widget/info_widget.dart';
import 'package:flutter/material.dart';

class CommentItemWidget extends StatefulWidget {
  const CommentItemWidget({
    super.key,
    required Map<String, dynamic> comentario,
  }) : _comentario = comentario;

  final Map<String, dynamic> _comentario;

  @override
  State<CommentItemWidget> createState() => _CommentItemWidgetState();
}

class _CommentItemWidgetState extends State<CommentItemWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentTema,
      builder: (BuildContext context, Brightness tema, _) {
        bool isDark = tema == Brightness.dark;

        return GestureDetector(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: UiEspaco.large),
            child: Column(
              crossAxisAlignment: widget._comentario['idUsuario'] ==
                      currentUsuario.value.idUsuario
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 0,
                  color: isDark ? UiCor.botaoSegundoEscuro : UiCor.botaoSegundo,
                  margin: const EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(UiBorda.arredondada),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(UiEspaco.medium),
                    child: TextoText(
                      texto: widget._comentario['isDeletado']
                          ? COMENTARIO_DELETADO
                          : widget._comentario['texto'],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 4, 0, UiEspaco.large),
                  child: InfoWidget(
                    item: widget._comentario,
                    tipo: InfoEnum.COMENTARIO.name,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
