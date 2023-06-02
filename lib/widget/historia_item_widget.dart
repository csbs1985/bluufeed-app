import 'package:bluufeed_app/class/categoria_class.dart';
import 'package:bluufeed_app/class/historia_class.dart';
import 'package:bluufeed_app/class/rotas_class.dart';
import 'package:bluufeed_app/firestore/usuario_firestore.dart';
import 'package:bluufeed_app/text/ellipsis_text%20.dart';
import 'package:bluufeed_app/widget/historia_info_widget.dart';
import 'package:bluufeed_app/text/tag_text.dart';
import 'package:bluufeed_app/text/titulo_text.dart';
import 'package:bluufeed_app/theme/ui_espaco.dart';
import 'package:bluufeed_app/widget/separador_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HistoriaItemWidget extends StatefulWidget {
  const HistoriaItemWidget({
    super.key,
    required Map<String, dynamic> snapshot,
  }) : _historia = snapshot;

  final Map<String, dynamic> _historia;

  @override
  State<HistoriaItemWidget> createState() => _HistoriaItemWidgetState();
}

class _HistoriaItemWidgetState extends State<HistoriaItemWidget> {
  final CategoriaClass categoriesClass = CategoriaClass();
  final UsuarioFirestore _usuarioFirestore = UsuarioFirestore();

  Map<String, dynamic> _historiaMap = {};

  Future<void> _definirUsuario() async {
    final _usuario =
        await _usuarioFirestore.getUsuarioId(widget._historia['idUsuario']);

    _historiaMap = {
      ...widget._historia,
      'avatarUsuario': _usuario.docs.first['avatarUsuario'],
      'nomeUsuario': _usuario.docs.first['nomeUsuario'],
    };
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _definirUsuario(),
      builder: (BuildContext context, _) {
        return InkWell(
          onTap: () => {
            currentHistoria.value = HistoriaModel.fromMap(_historiaMap),
            context.goNamed(RouteEnum.HISTORIA.value,
                pathParameters: {'idHistoria': _historiaMap['idHistoria']})
          },
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(UiEspaco.large),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TituloText(titulo: widget._historia['titulo']),
                    if (_historiaMap.isNotEmpty)
                      HistoriaInfoWidget(item: _historiaMap),
                    EllipsisText(texto: widget._historia['texto']),
                    Wrap(
                      children: [
                        for (var item in widget._historia['categorias'])
                          Padding(
                            padding:
                                const EdgeInsets.only(right: UiEspaco.small),
                            child: TagText(
                              tag: categoriesClass.pegarTextoCategoria(item),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              const SeparadorWidget(),
            ],
          ),
        );
      },
    );
  }
}
