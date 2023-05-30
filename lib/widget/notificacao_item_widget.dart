import 'package:bluufeed_app/class/notificacao_class.dart';
import 'package:bluufeed_app/class/rotas_class.dart';
import 'package:bluufeed_app/firestore/usuario_firestore.dart';
import 'package:bluufeed_app/text/data_text.dart';
import 'package:bluufeed_app/theme/ui_cor.dart';
import 'package:bluufeed_app/widget/avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:styled_text/styled_text.dart';

class NotificacaoItemWidget extends StatefulWidget {
  const NotificacaoItemWidget({
    super.key,
    required Map<String, dynamic> notificacao,
  }) : _notificacao = notificacao;

  final Map<String, dynamic> _notificacao;

  @override
  State<NotificacaoItemWidget> createState() => _NotificacaoItemWidgetState();
}

class _NotificacaoItemWidgetState extends State<NotificacaoItemWidget> {
  final NotificacaoClass _notificacaoClass = NotificacaoClass();
  final UsuarioFirestore _usuarioFirestore = UsuarioFirestore();

  Map<String, dynamic> _notificacaoMap = {};

  Future<void> _definirUsuario() async {
    final doc = await _usuarioFirestore
        .getUsuarioId(widget._notificacao['idRementente']);

    _notificacaoMap = {
      ...widget._notificacao,
      'nomeRemetente': doc.docs.first['nomeUsuario'],
      'avatarRemetente': doc.docs.first['avatarUsuario'],
    };
  }

  pathVizualizarNotificacao() {
    _notificacaoClass
        .pathVizualizarNotificacao(widget._notificacao['idNotificacao']);

    context.pushNamed(RouteEnum.HISTORIA.value,
        params: {'idHistoria': widget._notificacao['idConteudo']});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _definirUsuario(),
      builder: (BuildContext context, _) {
        return Container(
          child: _notificacaoMap.isEmpty
              ? null
              : InkWell(
                  onTap: () => pathVizualizarNotificacao(),
                  child: Container(
                    color: _notificacaoMap['isVisualizado']
                        ? UiCor.itemVirgem
                        : null,
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          child: AvatarWidget(
                              avatar: _notificacaoMap['avatarRemetente']),
                          onTap: () => context.pushNamed(RouteEnum.PERFIL.value,
                              params: {
                                'idUsuario': _notificacaoMap['idUsuario']
                              }),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              StyledText(
                                text: _notificacaoClass
                                    .definirConteudo(_notificacaoMap),
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                                softWrap: true,
                                overflow: TextOverflow.clip,
                                tags: {
                                  'bold': StyledTextTag(
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                },
                              ),
                              DataText(item: widget._notificacao),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
