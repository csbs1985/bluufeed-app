import 'package:bluufeed_app/class/categoria_class.dart';
import 'package:bluufeed_app/text/ellipsis_text%20.dart';
import 'package:bluufeed_app/widget/info_widget.dart';
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
  }) : _item = snapshot;

  final Map<String, dynamic> _item;

  @override
  State<HistoriaItemWidget> createState() => _HistoriaItemWidgetState();
}

class _HistoriaItemWidgetState extends State<HistoriaItemWidget> {
  final CategoriaClass categoriesClass = CategoriaClass();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.pushNamed('historia',
          params: {'idHistoria': widget._item['idHistoria']}),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(UiEspaco.large),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TituloText(title: widget._item['titulo']),
                InfoWidget(
                  tipo: InfoEnum.INICIO.name,
                  item: widget._item,
                ),
                EllipsisText(texto: widget._item['texto']),
                Wrap(
                  children: [
                    for (var item in widget._item['categorias'])
                      Padding(
                        padding: const EdgeInsets.only(right: UiEspaco.small),
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
  }
}
