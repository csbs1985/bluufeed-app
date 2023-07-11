import 'package:eight_app/class/atividade_class.dart';
import 'package:eight_app/class/rotas_class.dart';
import 'package:eight_app/text/data_text.dart';
import 'package:eight_app/widget/avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:styled_text/styled_text.dart';

class AtividadeItemWidget extends StatefulWidget {
  const AtividadeItemWidget({
    super.key,
    required Map<String, dynamic> atividade,
  }) : _atividade = atividade;

  final Map<String, dynamic> _atividade;

  @override
  State<AtividadeItemWidget> createState() => _AtividadeItemWidgetState();
}

class _AtividadeItemWidgetState extends State<AtividadeItemWidget> {
  final AtividadeClass _atividadeClass = AtividadeClass();

  String? _texto;

  @override
  Future<void> initState() async {
    iniciarAtividade();
    super.initState();
  }

  iniciarAtividade() {
    setState(() async {
      _texto = await _atividadeClass.formatarAtividade(widget._atividade);
    });
  }

  pathVizualizaratividade() {}

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.goNamed(RouteEnum.HISTORIA.value,
          pathParameters: {'idHistoria': widget._atividade['idConteudo']}),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              child: AvatarWidget(avatar: widget._atividade['avatarUsuario']),
              onTap: () => context.goNamed(RouteEnum.PERFIL.value,
                  pathParameters: {
                    'idUsuario': widget._atividade['idUsuario']
                  }),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StyledText(
                    text: _texto!,
                    style: Theme.of(context).textTheme.displayMedium,
                    softWrap: true,
                    overflow: TextOverflow.clip,
                    tags: {
                      'bold': StyledTextTag(
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    },
                  ),
                  DataText(item: widget._atividade),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
