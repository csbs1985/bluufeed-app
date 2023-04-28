import 'package:bluufeed_app/class/categoria_class.dart';
import 'package:bluufeed_app/class/rotas_class.dart';
import 'package:bluufeed_app/text/data_text.dart';
import 'package:bluufeed_app/text/tag_text.dart';
import 'package:bluufeed_app/text/texto_text.dart';
import 'package:bluufeed_app/text/titulo_text.dart';
import 'package:bluufeed_app/theme/ui_espaco.dart';
import 'package:bluufeed_app/widget/borda_widget.dart';
import 'package:bluufeed_app/widget/historia_menu_widget.dart';
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
    var _route = ModalRoute.of(context)?.settings.name;

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(
            UiEspaco.large,
            UiEspaco.small,
            UiEspaco.large,
            UiEspaco.medium,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TituloText(title: widget._item['title']),
              DataText(item: widget._item),
              GestureDetector(
                onTap: () => context.push(RouteEnum.HISTORIA.value),
                child: TextoText(
                  texto: widget._item['text'],
                  limiteLinha: 5,
                ),
              ),
              Wrap(
                children: [
                  for (var item in widget._item['categories'])
                    Padding(
                      padding: const EdgeInsets.only(right: UiEspaco.small),
                      child: TagText(
                        tag: categoriesClass.getCategoryLabel(item),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: UiEspaco.small),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: UiEspaco.medium),
                child: BorderWidget(),
              ),
              HistoriaMenuWidget(historia: widget._item),
            ],
          ),
        ),
        // if (_route != PageEnum.HISTORY.value)
        const SeparadorWidget(),
        // if (_route == PageEnum.HISTORY.value)
        Container(
          padding: const EdgeInsets.fromLTRB(
            UiEspaco.large,
            0,
            UiEspaco.large,
            UiEspaco.large,
          ),
          child: const BorderWidget(),
        ),
      ],
    );
  }
}
