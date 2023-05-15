import 'package:bluufeed_app/class/cor_class.dart';
import 'package:bluufeed_app/class/notificacao_class.dart';
import 'package:bluufeed_app/class/rotas_class.dart';
import 'package:bluufeed_app/text/data_text.dart';
import 'package:bluufeed_app/theme/ui_tema.dart';
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
  final CorClass _corClass = CorClass();
  final NotificacaoClass _notificacaoClass = NotificacaoClass();

  pathVizualizarNotificacao() {
    _notificacaoClass
        .pathVizualizarNotificacao(widget._notificacao['idNotificacao']);

    context.pushNamed(RouteEnum.HISTORIA.value,
        params: {'idHistoria': widget._notificacao['idConteudo']});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => pathVizualizarNotificacao(),
      child: ValueListenableBuilder(
        valueListenable: currentTema,
        builder: (BuildContext context, Brightness tema, _) {
          bool isDark = tema == Brightness.dark;

          return Container(
            color: _corClass.definirCor(
                isDark, widget._notificacao['isVisualizado']),
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  child: AvatarWidget(
                      avatar: widget._notificacao['avatarUsuario']),
                  onTap: () => context.pushNamed(RouteEnum.PERFIL.value,
                      params: {
                        'idUsuario': widget._notificacao['idRementente']
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
                            .definirConteudo(widget._notificacao),
                        style: Theme.of(context).textTheme.displayMedium,
                        softWrap: true,
                        overflow: TextOverflow.clip,
                        tags: {
                          'bold': StyledTextTag(
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        },
                      ),
                      DataText(item: widget._notificacao),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
