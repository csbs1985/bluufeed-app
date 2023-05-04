import 'package:algolia/algolia.dart';
import 'package:bluufeed_app/button/seguir_button.dart';
import 'package:bluufeed_app/text/texto_text.dart';
import 'package:bluufeed_app/theme/ui_tamanho.dart';
import 'package:bluufeed_app/widget/avatar_widget.dart';
import 'package:bluufeed_app/widget/sem_resultado_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UsuarioListaWidget extends StatefulWidget {
  const UsuarioListaWidget({
    super.key,
    required List<AlgoliaObjectSnapshot>? snapshot,
  }) : _snapshot = snapshot;

  final List<AlgoliaObjectSnapshot>? _snapshot;

  @override
  State<UsuarioListaWidget> createState() => _UsuarioListaWidgetState();
}

class _UsuarioListaWidgetState extends State<UsuarioListaWidget> {
  @override
  Widget build(BuildContext context) {
    double _altura =
        MediaQuery.of(context).size.height - (UiTamanho.appbar * 4);

    return widget._snapshot!.isEmpty
        ? SemResultadoWidget(altura: _altura)
        : Column(
            children: [
              const SizedBox(height: 16),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                reverse: true,
                itemCount: widget._snapshot!.length,
                separatorBuilder: (context, index) => const SizedBox(height: 4),
                itemBuilder: (context, index) => InkWell(
                  onTap: () => context.pushNamed('perfil', params: {
                    'idUsuario': widget._snapshot![index].data['idUsuario']
                  }),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              AvatarWidget(
                                size: 16,
                                avatar: widget
                                    ._snapshot![index].data['avatarUsuario'],
                              ),
                              const SizedBox(width: 8),
                              TextoText(
                                  texto: widget
                                      ._snapshot![index].data['nomeUsuario']),
                            ],
                          ),
                        ),
                        SeguirButton(
                            idUsuario:
                                widget._snapshot![index].data['idUsuario']),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}
