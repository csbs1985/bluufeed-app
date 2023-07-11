import 'package:eight_app/class/usuario_class.dart';
import 'package:eight_app/config/constant_config.dart';
import 'package:eight_app/firestore/usuario_firestore.dart';
import 'package:eight_app/text/texto_text.dart';
import 'package:eight_app/theme/ui_borda.dart';
import 'package:eight_app/theme/ui_cor.dart';
import 'package:eight_app/theme/ui_espaco.dart';
import 'package:eight_app/theme/ui_tema.dart';
import 'package:eight_app/widget/comentario_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

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
  final UsuarioFirestore _usuarioFirestore = UsuarioFirestore();

  Map<String, dynamic> _cometarioMap = {};

  int index = 1;

  Future<void> _definirUsuario() async {
    try {
      final _usuario =
          await _usuarioFirestore.getUsuarioId(widget._comentario['idUsuario']);

      _cometarioMap = {
        ...widget._comentario,
        'avatarUsuario': _usuario.docs.first['avatarUsuario'],
        'nomeUsuario': _usuario.docs.first['nomeUsuario'],
      };
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _definirUsuario(),
      builder: (BuildContext context, _) {
        return ValueListenableBuilder(
          valueListenable: currentTema,
          builder: (BuildContext context, Brightness tema, _) {
            bool isDark = tema == Brightness.dark;

            return InkWell(
              onTap: () => {},
              child: Container(
                padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                child: !_cometarioMap.isNotEmpty
                    ? null
                    : AnimationConfiguration.staggeredList(
                        position: index++,
                        duration: const Duration(milliseconds: 100),
                        child: SlideAnimation(
                          verticalOffset: 50,
                          child: FadeInAnimation(
                            child: Column(
                              crossAxisAlignment:
                                  widget._comentario['idUsuario'] ==
                                          currentUsuario.value.idUsuario
                                      ? CrossAxisAlignment.end
                                      : CrossAxisAlignment.start,
                              children: [
                                Card(
                                  elevation: 0,
                                  color: isDark
                                      ? UiCor.botaoSegundoEscuro
                                      : UiCor.botaoSegundo,
                                  margin: const EdgeInsets.all(0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        UiBorda.arredondada),
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.all(UiEspaco.medium),
                                    child: TextoText(
                                      texto: widget._comentario['isDeletado']
                                          ? COMENTARIO_DELETADO
                                          : widget._comentario['texto'],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 4, 0, 8),
                                  child:
                                      ComentarioInfoWidget(item: _cometarioMap),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
              ),
            );
          },
        );
      },
    );
  }
}
